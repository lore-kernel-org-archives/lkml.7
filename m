Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A259CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 13:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3C4A21721
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 13:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572354616;
	bh=Z4nt9AgzF6Xut8DoxIHw3oYYKPwQnKcdpMCaKKFH34M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RJ+O2qUcmehhkFJaIYwwtczq1DBsRyAt7ciMX/vZ2XDzlFFCtz4IYfBB7fSk5WtiB
	 OJL+bgZ6P+AWSx37SowEnHIhWnS0iGSz095lzOFi4kKZXbzUNmbLoIvYMaSK92Atuq
	 /1GfaNpj9jPK2BF+CZ+bnlZTLIy/+R+LcGQx9gA0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388142AbfJ2NKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 09:10:15 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50350 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728735AbfJ2NKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 09:10:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=b96Hgh9Bd/Vy2G8CXvhuxvxQ6kIj7r6GOtFsPFFUW+8=; b=cJFPRsfXUSMyr9M1w3e5y4y63
        YcKhrJWRetefxiN1ARvraFKrPNnwVBtiKkeeuhPycWtPxuZt3O///M531BOeO2zL1pCM+VPYLrfSd
        Z3q1SG8Nfuji47jkCzf5A60N81azDjsyMxy1LmtcemQi/kxjyMUVXtLbbka+FJF+64gbo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iPRG2-0002HP-B2; Tue, 29 Oct 2019 13:09:58 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 9ADA12742157; Tue, 29 Oct 2019 13:09:57 +0000 (GMT)
Date:   Tue, 29 Oct 2019 13:09:57 +0000
From:   Mark Brown <broonie@kernel.org>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     bardliao@realtek.com, oder_chiou@realtek.com, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: rt5677: Make rt5677_spi_pcm_page static
Message-ID: <20191029130957.GE5253@sirena.co.uk>
References: <1571919319-4205-1-git-send-email-zhongjiang@huawei.com>
 <5DB7AD30.60007@huawei.com>
 <20191029122435.GD5253@sirena.co.uk>
 <5DB8383C.7040601@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="19uQFt6ulqmgNgg1"
Content-Disposition: inline
In-Reply-To: <5DB8383C.7040601@huawei.com>
X-Cookie: When does later become never?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--19uQFt6ulqmgNgg1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 29, 2019 at 09:01:48PM +0800, zhong jiang wrote:
> On 2019/10/29 20:24, Mark Brown wrote:

> I send the patch, but alway receive the following responses.

> This message is from the Forcepoint email protection system, Forcepoint Email Security at host huawei.com.

> The attached email could not be delivered to one or more recipients.

> For assistance, please contact your email system administrator and include the following problem report:

> <bardliao@realtek.com>: host rtits1.realtek.com[211.75.126.71] said: 553 5.7.1
> <oder_chiou@realtek.com>: host rtits1.realtek.com[211.75.126.71] said: 553

> Do the mails fails to send the receivers ? The mails is empty content. I have no ideas about that.

Bard left Realtek and I think Oder did too though I'm not 100% sure
which is why mail to them is bouncing - but looking back I didn't get
your original patch either though so you had some problem it seems (also
you've not sent it to alsa-devel).  As I said in the mail you're
replying to probably best to resend.

--19uQFt6ulqmgNgg1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl24OiQACgkQJNaLcl1U
h9AV7wf+IicQjLXJJBCrJwAOIUcw6M+evtaSF6Kz5XMGAyDnXDGVRpfTSDfn1Zkg
G8IMn8Ts021CE4p3MsGKRq9M6/buSRhPiG9r8Kum1faVDRdID7BrnbLR1tPViZh6
tXhN5ZxOR7jKApP38M02vuHZUY6Sa978jEoH9Y9AIJ3ztFNVJcNp1TOk7ThWHzUw
YNAyW4adI8q9r1ffPczau5E6bN2LTYZx1h12mvI63IPbuQVaTVKCEjBnGtGmvRHJ
64CJIz7JTG0tAGNdmIEIY3D5vBU+cD4I627iAEsqoRdgwd8dJx0j25CmMsF1RwbE
Yj2Z2Q0AQGNQoIPmdeKH5Lg4JZn94w==
=LE0m
-----END PGP SIGNATURE-----

--19uQFt6ulqmgNgg1--
