Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D9BC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 12:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 260542082C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 12:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561034667;
	bh=c1rSzWptSdxxYx7mBfYCeDiH2JuZGxkohKszdGX95gY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Kk+KUyfEXubfnZ1KuoiLVHYyQJ5QBKUDPgydbzn9/UctCxIdCUWvCZmhCZFoTRZAA
	 RQelQj7Xdd2+ewZ1sZnRHQU0I6iMndFGr2wA3Go1wrYgbzF16etw1FE8InljarvUnb
	 3E/BARRg0hgRNR5h0CAwJ5he817wJ/IYZ2w2m+x4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731822AbfFTMoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 08:44:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726874AbfFTMoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 08:44:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F0332082C;
        Thu, 20 Jun 2019 12:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561034664;
        bh=c1rSzWptSdxxYx7mBfYCeDiH2JuZGxkohKszdGX95gY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Se/nyQTK9zv12raOigAW8XfX53KRu01qcWo3aa2YLl8OV0aD0EBUcapQrQ/pFFXL4
         KSGEw+L15cPNzUpUaoQusy5sym3ih3w0NpQ/+8Oc3zUo1Z7ddTOvjeSeqEC5JUGPj4
         i5lGS+QMo8FIcNvDLpdK/XQ4miVwPoK8CvpSgfak=
Date:   Thu, 20 Jun 2019 14:44:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: HalBtc8723b1Ant: fix Using
 comparison to true is error prone
Message-ID: <20190620124422.GA28753@kroah.com>
References: <20190619180439.GA7217@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619180439.GA7217@hari-Inspiron-1545>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 11:34:39PM +0530, Hariprasad Kelam wrote:
> This patch fixes below issue reported by checkpatch
> 
> CHECK: Using comparison to true is error prone
> CHECK: Using comparison to false is error prone
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> ---
>  drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Does not apply to my tree :(
