Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDC0C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 12:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBD882087F
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 12:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552826308;
	bh=qSxeWZZaFs0DJAO57qrUzL3VsqjjNbCiuDph3wI9wVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eL77MchNCtAYFskxBRG/ACWYeXN7pPSzCoKEGRp8ydIC2rnMMBiuyS1kMme2Sg3Je
	 OKRC06lGQOl5i4wvuKQUEZ9aXoGXejAhZv7CM4mu8SHIDTDZW88lAsYL4bSqxZwnG8
	 MZMuxMSCbfyzKeg+U+JVbECAhHBHq+SrOYVAgjBA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfCQMi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 08:38:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:50752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726855AbfCQMi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 08:38:26 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15F6020872;
        Sun, 17 Mar 2019 12:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552826305;
        bh=qSxeWZZaFs0DJAO57qrUzL3VsqjjNbCiuDph3wI9wVk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KFiaWcMkscXip80KuD+18BHLwyXl4cXrfjD4btwGd/M7Veehvps9Vf7Db4b0ojDGh
         12xZYD4DmDxBayRUKrMxszYWAJLXW0geItRc4z5ZJeTSlPWXklSLtX1pEEqaHpQc0g
         pUI0mtI3p639NrWicRazITBIENVAA1LUFTagXptA=
Date:   Sun, 17 Mar 2019 13:38:23 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Emanuel Bennici <benniciemanuel78@gmail.com>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Eric Anholt <eric@anholt.net>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: vc04_services: Add blank line after struct
 declaration
Message-ID: <20190317123823.GA9496@kroah.com>
References: <20190317015930.GA1747@p200300EEEE2F.fritz.box>
 <20190317095502.GC6906@kroah.com>
 <e62c9952-190b-d232-4987-5e1a05e16a57@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e62c9952-190b-d232-4987-5e1a05e16a57@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2019 at 01:14:26PM +0100, Emanuel Bennici wrote:
> 
> Am 17.03.19 um 10:55 schrieb Greg Kroah-Hartman:
> > On Sun, Mar 17, 2019 at 02:59:32AM +0100, Emanuel Bennici wrote:
> >> Signed-off-by: Emanuel Bennici <benniciemanuel78@gmail.com>
> >> ---
> >>  drivers/staging/vc04_services/interface/vchi/vchi.h | 1 +
> >>  1 file changed, 1 insertion(+)
> > I can not take patches without any changelog information, sorry.
> 
> Add blank Line after declaration of struct vchi_version to fix checkpatch.pl
> Check `CHECK: Please use a blank line after function/struct/union/enum
> declarations`.
> 
> Signed-off-by: Emanuel Bennici <benniciemanuel78@gmail.com>
> ---
>  drivers/staging/vc04_services/interface/vchi/vchi.h | 1 +
>  1 file changed, 1 insertion(+)
> 

<snip>

Sorry, I can't take a patch that I have to hand-edit either.

Please fix up and resend the series correctly, with a proper version
information about what changed from the previous patch series as the
kernel process documentation explains.

thanks,

greg k-h
