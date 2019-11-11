Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79EBC17443
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 06:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7FC42067B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 06:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573452784;
	bh=NthoupRoaY5yarrl2arVlGsOeFSOOPS5cv6/FC6a8fo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NLZzf0iBQ0IMLvk/tUsAhGvWAGW/myttluzELSuj0DOEK85AvxcEYF+WUbY1I4jrc
	 YQJNfBu70MMF/eq+jM5fEWfKTjBhfTWCtPQhOZp2O2KvaUsLu5wlhg1Y7HRaqoopgH
	 c08aImUn9/TG2oE6o1hZ/1eyoh0FzyEBNL/hLFHY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfKKGND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 01:13:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:50392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbfKKGND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 01:13:03 -0500
Received: from localhost (unknown [106.201.42.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F12F72067B;
        Mon, 11 Nov 2019 06:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573452782;
        bh=NthoupRoaY5yarrl2arVlGsOeFSOOPS5cv6/FC6a8fo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FALGwTePjsC0UkM2Pa/mIRJPHz0f+YjhRPz7DPMOR5l1LVU1xgcB5Ytvx4BLj8Pfo
         hftYoBXw4EKbE81flNNCRus1AGaRYIhuqtzuXvOKSH2OkSDn635soJYFcMSR3l4/vt
         wfCVGCenhiXc5K9pv4td8f7gdywcg3hg75vmZHOg=
Date:   Mon, 11 Nov 2019 11:42:58 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     robh+dt@kernel.org, nm@ti.com, ssantosh@kernel.org,
        dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, grygorii.strashko@ti.com,
        lokeshvutla@ti.com, t-kristo@ti.com, tony@atomide.com,
        j-keerthy@ti.com
Subject: Re: [PATCH v4 15/15] dmaengine: ti: k3-udma: Add glue layer for non
 DMAengine users
Message-ID: <20191111061258.GS952516@vkoul-mobl>
References: <20191101084135.14811-1-peter.ujfalusi@ti.com>
 <20191101084135.14811-16-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101084135.14811-16-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-11-19, 10:41, Peter Ujfalusi wrote:
> From: Grygorii Strashko <grygorii.strashko@ti.com>
> 
> Certain users can not use right now the DMAengine API due to missing
> features in the core. Prime example is Networking.
> 
> These users can use the glue layer interface to avoid misuse of DMAengine
> API and when the core gains the needed features they can be converted to
> use generic API.

Can you add some notes on what all features does this layer implement..

-- 
~Vinod
