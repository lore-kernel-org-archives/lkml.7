Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC89C47E49
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 02:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1949D21929
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 02:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571971731;
	bh=L4DLVp2hZ/o4RJN3rGahjsfhwF0etIeief3IP0yUQH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PuO08R86bzXTp/hbwm4Dr1tQOOZzqR5bSF3b3WG1hsl8DC1qzB+BC6BDLqnqCdkYY
	 RYhSCUhbUN7yetOCOIwgtWsOhbNjmblVONt9bF0lJyUeTa7T/wH1Cb7UBr/up1QuWy
	 Z/Vp1rj0tWGh2i8koYS681bdet+dz6HxxqwatKVQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390925AbfJYCst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 22:48:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:54832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728416AbfJYCss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 22:48:48 -0400
Received: from localhost (unknown [38.98.37.137])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2AC421D7F;
        Fri, 25 Oct 2019 02:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571971728;
        bh=L4DLVp2hZ/o4RJN3rGahjsfhwF0etIeief3IP0yUQH0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JX7ReB90jHSaOwKSrULomev4Yp3u8LLIMnaZWbtGNieit+Sogd0G8fvVexeqrZL6C
         qsagBnhKVgFk9xthSMguPnIMBfrPLCod1RCMvPyXi1MQ+aPxnOfGqcpj0AqxZjhskB
         kzYCk0K0LA88Re95SINmxvbyj5U2nB7ESy0bfhv8=
Date:   Thu, 24 Oct 2019 22:43:08 -0400
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Valdis Kletnieks <valdis.kletnieks@vt.edu>
Cc:     linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] staging: exfat: Update TODO
Message-ID: <20191025024308.GA331878@kroah.com>
References: <20191023052752.693689-1-Valdis.Kletnieks@vt.edu>
 <20191023052752.693689-9-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023052752.693689-9-Valdis.Kletnieks@vt.edu>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 01:27:51AM -0400, Valdis Kletnieks wrote:
> Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
> ---
>  drivers/staging/exfat/TODO | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)

I can't take patches without any changelog text, sorry :(
