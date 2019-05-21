Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CDFDC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 14:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BC8B21479
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 14:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558447312;
	bh=LNDtj+p6qU3r67+ocgpSi5ncMC3Yz/CpRU5mwiTPnGI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ab8cPyEqagI5sYgLWxL6N5UALDCeIV3fSDAB1ClnVFeiOZT2Pj1fmkGAwL5QJBe/Z
	 N4zNzoEJNw9oPZBaZ1FeVd1jGTgwVIa+IaWQaa4q7TD64kKlfaxjFtmd4kBxuE3MvC
	 5ytwBkIbab9ZWbLu78CSvi58UicAFVWLfAJ+Ovrg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbfEUOBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 10:01:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:38870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727262AbfEUOBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 10:01:50 -0400
Received: from localhost (unknown [106.51.105.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C72C521743;
        Tue, 21 May 2019 14:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558447310;
        bh=LNDtj+p6qU3r67+ocgpSi5ncMC3Yz/CpRU5mwiTPnGI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bJEplRpQvhI53BWvqwOvhAGXW+mUoXtl7rbCjZ9njTRZJq0kjAA1XDwkytgTQD6tv
         VsNU4QlW1RwJmdH176Mxz6hOVsIfcF9sUnM+qoqYi+JuMXAWN0DPWQijkwJVIRkLFW
         xSt5fjtQcQxcRFII6YOG82sMtayTYmn7a9++SL9A=
Date:   Tue, 21 May 2019 19:31:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Long Cheng <long.cheng@mediatek.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Sean Wang <sean.wang@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sean Wang <sean.wang@mediatek.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, srv_heupstream@mediatek.com,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>,
        Zhenbao Liu <zhenbao.liu@mediatek.com>
Subject: Re: [PATCH 3/4] dt-bindings: dma: uart: rename binding
Message-ID: <20190521140145.GP15118@vkoul-mobl>
References: <1556336193-15198-1-git-send-email-long.cheng@mediatek.com>
 <1556336193-15198-4-git-send-email-long.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556336193-15198-4-git-send-email-long.cheng@mediatek.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-04-19, 11:36, Long Cheng wrote:
> The filename matches mtk-uart-apdma.c.
> So using "mtk-uart-apdma.txt" should be better.
> And add some property.

Applied with Robs r-b tag in last version, thanks
Also fixed a trailing line in patch :(

-- 
~Vinod
