Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83ADC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 12:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F42821842
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 12:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564747748;
	bh=eVguHjWk86Hw5IEsVwfh49P+hgbGzKP3Oa7z7KVVRYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TjEaBl7vj20mh/4dEyZdhv8JypEvMWLvPxLTa9WKZifKj2R5zfOdrezRmH+lPHPT8
	 fQGJAKTdObjmomzxpCZQqkNLgjCObD8q2w6GHSXAEPg87YvHokAuxD+DxCNTmI4u2I
	 Mum4MjWC2cxsg79GyUaWOJUROQyXHYYPteVTTNRg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387715AbfHBMJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 08:09:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:58068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729980AbfHBMJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 08:09:05 -0400
Received: from localhost (unknown [122.167.106.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 522EC2087C;
        Fri,  2 Aug 2019 12:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564747745;
        bh=eVguHjWk86Hw5IEsVwfh49P+hgbGzKP3Oa7z7KVVRYQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LPD/PHObEaYLp7Mc5qXaIQNRs31OhOQmDmgl0SDT6i5BHh2C9ufMyiy5qWMmPatXF
         zx2q53UkGHNF6orYqgdjizHJ9sf7mKfLm/e6uGJ88SJyMy6r+FNZc23bS53R1nPSvA
         e4iAgrX6CdlwaUq1DEov5NYy9r1sljbalnE23WyY=
Date:   Fri, 2 Aug 2019 17:37:51 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [RFC PATCH 11/40] soundwire: cadence_master: simplify bus clash
 interrupt clear
Message-ID: <20190802120751.GM12733@vkoul-mobl.Dlink>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-12-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725234032.21152-12-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-07-19, 18:40, Pierre-Louis Bossart wrote:
> The bus clash interrupts are generated when the status is one, and
> also cleared by writing a one. It's overkill/useless to use an OR when
> the bit is already set.

IIRC we were supposed to have different variable and that was the reason
for setting, yes should be removed.

I have applied this one as well

-- 
~Vinod
