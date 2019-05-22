Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34F4C072A4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 08:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5962206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 08:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=azazel.net header.i=@azazel.net header.b="F0BCeGBv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbfEVIkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 04:40:19 -0400
Received: from kadath.azazel.net ([81.187.231.250]:42622 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbfEVIkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 04:40:19 -0400
X-Greylist: delayed 2571 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 May 2019 04:40:19 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=G/En3bk+2yjBN1OlAPMBLUMv2j8iGWc8pYHVEqKjRvk=; b=F0BCeGBvaK40XFQmcuTdNLbkXy
        EVpcjKizrH8GOKcY9BRWWnM0/pXY3vFqZE/lF2FtudhSWWl/DXy5mRIy/XDtYFrDfe6BT3XPVvvUR
        CB373mpkXUcN5lkws2TXyJpRM7feAawBb+mOBDXU0vtzBIrXO5/7MV0wjp16iFD3JqwOPRhXOItJx
        O0xb1aUqeHLUS6ZscwrHNxuUIKYzvnhfWjhmOa7hG5tB/dniiK903VRyBVgcYrpdKMuYPPakkQkhX
        cAv3PetOTzNQSTHAFY5+P3iqUJNhcf8FkwqnaLSQtG2hO64BE+Y9WoFACn5l5gkXiG0ShiNZvwV+I
        wSxm0UKw==;
Received: from ulthar.dreamlands ([192.168.96.2] helo=azazel.net)
        by kadath.azazel.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <jeremy@azazel.net>)
        id 1hTM7h-0000A1-C4; Wed, 22 May 2019 08:57:17 +0100
Date:   Wed, 22 May 2019 08:57:16 +0100
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Fabio Lima <fabiolima39@gmail.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org
Subject: Re: [PATCH] staging: rtl8723bs: Add missing blank lines
Message-ID: <20190522075716.GA16243@azazel.net>
References: <20190522004655.20138-1-fabiolima39@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <20190522004655.20138-1-fabiolima39@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 192.168.96.2
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 2019-05-21, at 21:46:55 -0300, Fabio Lima wrote:
> This patch resolves the following warning from checkpatch.pl
> WARNING: Missing a blank line after declarations
>
> Signed-off-by: Fabio Lima <fabiolima39@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_debug.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/staging/rtl8723bs/core/rtw_debug.c b/drivers/staging/rtl8723bs/core/rtw_debug.c
> index 9f8446ccf..853362381 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_debug.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_debug.c
> @@ -382,6 +382,7 @@ ssize_t proc_set_roam_tgt_addr(struct file *file, const char __user *buffer, siz
>  	if (buffer && !copy_from_user(tmp, buffer, sizeof(tmp))) {
>
>  		int num = sscanf(tmp, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx", addr, addr+1, addr+2, addr+3, addr+4, addr+5);
> +
>  		if (num == 6)
>  			memcpy(adapter->mlmepriv.roam_tgt_addr, addr, ETH_ALEN);
>
> @@ -1348,6 +1349,7 @@ int proc_get_btcoex_dbg(struct seq_file *m, void *v)
>  	struct net_device *dev = m->private;
>  	struct adapter *padapter;
>  	char buf[512] = {0};
> +
>  	padapter = (struct adapter *)rtw_netdev_priv(dev);
>
>  	rtw_btcoex_GetDBG(padapter, buf, 512);
> --
> 2.11.0

Looks good to me.

J.

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEZ8d+2N/NBLDbUxIF0Z7UzfnX9sMFAlzlANUACgkQ0Z7UzfnX
9sPLkQ/+Ont4TYXB8nKa47x1cKKjE8M0Jucl5n4n1+kOPZ13aM3g2vCAxPLpQ3ii
XcS1u3cJVw928v0ZNIb8UD9v0oJMXu6wYcIupTPwCVb8wd26Ull3k/8RoORuaTzi
gFKkSkyB8osSLWK1EsUcF3zTLm/rMFNXAOjAo40z6fKw4DDsRm9X74jMY4O52IzR
o/IbfENqe7XPMC8b+zg5py/HgI89+zqBK2jnLyUV5X1tXNvYpPZpqonAndwee6ME
xUegqgQ+RbcKCVBloXbHCpyEU4pwbRlHS8CsuJwyHRoMlcG+ktpLj+59NxQ02Ya8
FPEMoiRsLVm3tJZfkO8GIai702ZdWh4piaukJQHX87C+2F33tzts0MRfWuN3Pmtq
Vbkoetf5/DOlLiXBXyYKCHNe4+5HaEYPtDSOlH5x4+8IUMiG/PMrIa+o1+2xmc3c
njGM2OMScTWZWTEs+RX8z/QsNCuRj26VRw45XSWSATwpv8ZxnfeCqcrv/rDD0umg
sh0WLCHIXEIZoqGPRlkTvZbqfGCT29PTJyDlRT3xAC6i0eLx3ZdQP5LokaTiepN/
vgI3lCbycP23QlBmwbitpZ3Ep33dQiimnfcPw2lP7pvZOyYWiDTZB5S2M6PMIp9V
qCclrb5N8/U0IswlNJFtCWZApPdFL2faZvaNbW19zSDE+iDFpeQ=
=mWNx
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
