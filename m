Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55238ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 07:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B4DF20854
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 07:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571037246;
	bh=PAFFT3cTE0jAHpXoWLo9/M6t2Qj+7XgxtjVu/+SGEN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qZH9JjzIZ6HZPZ7MK61yyUTDmJHrYwSddGzZxszUZoCrWjWcTvW2swus9h5CzilGB
	 VZgPQTWhO+DaVTcvo09Z8D4VcepCthOzvW7B42gTkRpZXqz7Sg5jk9dw4SawZACnOn
	 AQ5+LgXPTVlsWD/abeRG3nQmz7m7gJ6UgL6GYPBY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730217AbfJNHOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 03:14:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:33210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729928AbfJNHOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 03:14:04 -0400
Received: from localhost (unknown [122.167.124.160])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 638312083B;
        Mon, 14 Oct 2019 07:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571037244;
        bh=PAFFT3cTE0jAHpXoWLo9/M6t2Qj+7XgxtjVu/+SGEN8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZQ4R2MI2ZMNXkoe1tTd4su0WqdIvszSZ50M7njjgD76dWRh8WPuL7X0Y1BBQvYA6o
         XYc02BXjIeRZ9QL+cUPbyhUHki3yImilorvNoVaH/pcn9KP3pm5LbmmUjPmKpY7jEk
         MJxNDsNktoe+bfHWKQ34bqi1E0+Woc5X9P7iSJ4c=
Date:   Mon, 14 Oct 2019 12:44:00 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Markus Elfring <Markus.Elfring@web.de>, dmaengine@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, Alex Smith <alex.smith@imgtec.com>
Subject: Re: [PATCH] dmaengine: jz4780: Use devm_platform_ioremap_resource()
 in jz4780_dma_probe()
Message-ID: <20191014071400.GD2654@vkoul-mobl>
References: <5dd19f28-349a-4957-ea3a-6aebbd7c97e2@web.de>
 <1569353552.1911.0@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1569353552.1911.0@crapouillou.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-09-19, 21:32, Paul Cercueil wrote:
> Hi Markus,
> 
> 
> Le dim. 22 sept. 2019 à 11:25, Markus Elfring <Markus.Elfring@web.de> a
> écrit :
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Sun, 22 Sep 2019 11:18:27 +0200
> > 
> > Simplify this function implementation a bit by using
> > a known wrapper function.
> > 
> > This issue was detected by using the Coccinelle software.
> > 
> > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> 
> Looks good to me.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Did you mean Acked or Reviewed ...??

-- 
~Vinod
