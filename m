Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1070DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 02:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBA1C2070B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 02:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbfC1CNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 22:13:20 -0400
Received: from smtprelay0154.hostedemail.com ([216.40.44.154]:43214 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725948AbfC1CNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 22:13:20 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 084C2180286C5;
        Thu, 28 Mar 2019 02:13:19 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: stew27_1cbfbbbf8d742
X-Filterd-Recvd-Size: 1914
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Thu, 28 Mar 2019 02:13:17 +0000 (UTC)
Message-ID: <c732d470fe9ceec03b65cb92ea997e6db4e6385d.camel@perches.com>
Subject: Re: [PATCH v2] staging: rtl8723bs: core: fix line over 80
 characters warning
From:   Joe Perches <joe@perches.com>
To:     Anirudh Rayabharam <anirudh.rayabharam@gmail.com>,
        gregkh@linuxfoundation.org, hadess@hadess.net, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net, dan.carpenter@oracle.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Wed, 27 Mar 2019 19:13:16 -0700
In-Reply-To: <20190327181836.GA37876@auvm>
References: <20190326182309.GA33380@auvm> <20190327181836.GA37876@auvm>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-03-27 at 23:49 +0530, Anirudh Rayabharam wrote:
> Checkpatch.pl complains that these lines are over 80 characters. Use the
> "psecuritypriv" pointer for consistency, remove unnecessary parantheses
> and fix the alignment.
> 
> This patch just cleans up a condition, it doesn't affect runtime.
[]
> diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
[]
> @@ -2336,8 +2336,8 @@ void rtw_ap_restore_network(struct adapter *padapter)
>  			Update_RA_Entry(padapter, psta);
>  			/* pairwise key */
>  			/* per sta pairwise key and settings */
> -			if ((padapter->securitypriv.dot11PrivacyAlgrthm == _TKIP_) ||
> -				(padapter->securitypriv.dot11PrivacyAlgrthm == _AES_)) {
> +			if (psecuritypriv->dot11PrivacyAlgrthm == _TKIP_ ||
> +			    psecuritypriv->dot11PrivacyAlgrthm == _AES_) {
>  				rtw_setstakey_cmd(padapter, psta, true, false);
>  			}

You could remove the unnecessary {} braces here too


