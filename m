Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B52C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 21:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE50206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 21:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="soNxNq/8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbfG3Vhw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 17:37:52 -0400
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:44964
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726539AbfG3Vhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 17:37:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1564522668; bh=zrrhb62cSoHIWyvSdYWD56aWq5TyLcbALfqzakcPZhM=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=soNxNq/8nMO7l3B+rSh4wTtw7wHnk3Rf+OFQuQ7FYID0b2qoLC5WkGrW4XOt0LIc5mSGoJwftruFjYxgNl0dIenNgldHGf0vdAmly0U/w6zEg5z5ueyexnx6wK4V5dadH+/zIjcHNHfWYUEGJTeKQ8SEIDGgBvg9CLUupp0BTUCZG1Zt1Na6XDajS7U6cEWTZb9KfXZTtwbK242Znzuc2Bu87K5HnHH6o3npHJxKLuTQ59d0/5jw6z8YQ1GGqqzut6MFHIALmyWLic89n5GdkKtRm9dni+MFzFuhd8REfBZsWsja0c+/JSDvWGwvpWIJNVZ7lBoQjkNb6P1dWS8FmQ==
X-YMail-OSG: lYB5LKUVM1nJDTvMyMdypeCpLPagsof3C3ya_Y_DXs4OQ4O6yJGYwao_qnToSij
 Rzxp6CR1fr0TqQec5npHnELVef6tf4G6swYKUmqvA59Vxa0oaJ1oCj3PzjoduQS0Rx9zzfQ2ECuu
 dGVGrfvxYqHC8gdVAcs_INGDkxxjIBBhvGqhTr1WMkZ3ZsWGUJ2feZJoQyqy4T5_Bz2MLU1MiWdg
 BJZ5l96kRodouGTyDnP_.xjZFVMLUoJPzmjlGDRvX6EZRNEZqBUvJigALD9YYht7FP4Kp1NnRc6p
 xCbvFGJuLV2fAWRIbh1dSQoWjVZLM7ZDIk8zUx4xR7QVo2tDLIXYNE0Svx2bGoPMzKy3X77ep2tV
 UlwzWaoKXsV498PWP5wcXdtqq72tq87FXYhdT9MaRwDl0P6VfR4GE0d1hwqFvxcXGEQbTzMGNscp
 lBKWPVIp0i8ZqKKNKxHGtkjZSQo34fPCrXufTPptMGlBo0pVJrjrPfqN1ZuRTh9VfQfpFHNqpYIi
 uD6B50DpZnplpzxEjifJY7tqjJqzi1.71wsX1Vn3glx6PTQHvZOTI9oZsXY00ETDNEg11I7T9Wz5
 hWMxYHSWtf0eTkXbMEwivBgBKgjVr1uhEiI1EBA4_K157w3yVnDjQ1ijEuhwa2t.5kkIG6VqPMY9
 1qBkN6cOeGp.inQwJqksjVE0zY9MlWPGUbO_jwHvvkRAEPGN51jYwbVSKuLbVFByVcphkp3PrkeL
 XJ5kp6SxxWCd562SYWxhYzRoea2Du1IuMRKqHoHklQskAmCBsk709ICRMNO8bnWRYT_zO7D8YddA
 WNnt97dLIDeXlXDCE1Hwnbiz0VK_wsRYgl0F1_MNlxxKQmkUAdd6U5nk74OrSHXlWLNe75JWKg6U
 bndA.SpTL8Z4CDWyZGuvkQipvOLFuId8QI.vRbqPswGp06p81VmMBnw7Jmix6HQn33q84kc2WshI
 phd.gRaMvqL1M11JwsthoG4H03N1XB7cZ0cY.YSK.v8.apI4ymoJqkpWYyVx7puUxkESVko7WM2B
 jsU4Bym5erIxUf7Iy9PzDRPnVEYNDEFvxbRtizBB4VolL92VijQ2fVKdKYDwPPJhtaHzJj_K7CKu
 EV4fl0C4bsZ2kaYsi2ybKdGXaVffELR.89gsSR98Lx2YEimVE0UDpxfV0ffWG_oFv.FHk6AP7Bob
 _lJqSIyGULLJSl2mFe2Ehz6wonED0caXx3OsDJjoXIXQLAz88xEL0PNrdOryFCZqNUJ9zISJCTnt
 lnQ4KGg6nteP2pyU6lM2Fdz72NQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Tue, 30 Jul 2019 21:37:48 +0000
Received: by smtp412.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 012fd6c3010b184d88945152a93467a4;
          Tue, 30 Jul 2019 21:37:48 +0000 (UTC)
Subject: Re: [PATCH v12 0/5] overlayfs override_creds=off
To:     Mark Salyzyn <salyzyn@android.com>, linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-unionfs@vger.kernel.org, linux-doc@vger.kernel.org,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
References: <20190730172904.79146-1-salyzyn@android.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <36b08762-3bd5-b7de-85c1-508e367971b1@schaufler-ca.com>
Date:   Tue, 30 Jul 2019 14:37:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190730172904.79146-1-salyzyn@android.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/30/2019 10:28 AM, Mark Salyzyn wrote:
> Patch series:

Please add linux-security-module@vger.kernel.org to the CC
for all changes affecting handling of security xattrs.

>
> overlayfs: check CAP_DAC_READ_SEARCH before issuing exportfs_decode_fh
> Add flags option to get xattr method paired to __vfs_getxattr
> overlayfs: handle XATTR_NOSECURITY flag for get xattr method
> overlayfs: internal getxattr operations without sepolicy checking
> overlayfs: override_creds=off option bypass creator_cred
>
> The first four patches address fundamental security issues that should
> be solved regardless of the override_creds=off feature.
> on them).
>
> The fifth adds the feature depends on these other fixes.
>
> By default, all access to the upper, lower and work directories is the
> recorded mounter's MAC and DAC credentials.  The incoming accesses are
> checked against the caller's credentials.
>
> If the principles of least privilege are applied for sepolicy, the
> mounter's credentials might not overlap the credentials of the caller's
> when accessing the overlayfs filesystem.  For example, a file that a
> lower DAC privileged caller can execute, is MAC denied to the
> generally higher DAC privileged mounter, to prevent an attack vector.
>
> We add the option to turn off override_creds in the mount options; all
> subsequent operations after mount on the filesystem will be only the
> caller's credentials.  The module boolean parameter and mount option
> override_creds is also added as a presence check for this "feature",
> existence of /sys/module/overlay/parameters/overlay_creds
>
> Signed-off-by: Mark Salyzyn <salyzyn@android.com>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Stephen Smalley <sds@tycho.nsa.gov>
> Cc: linux-unionfs@vger.kernel.org
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
>
> ---
> v12:
> - Restore squished out patch 2 and 3 in the series,
>   then change algorithm to add flags argument.
>   Per-thread flag is a large security surface.
>
> v11:
> - Squish out v10 introduced patch 2 and 3 in the series,
>   then and use per-thread flag instead for nesting.
> - Switch name to ovl_do_vds_getxattr for __vds_getxattr wrapper.
> - Add sb argument to ovl_revert_creds to match future work.
>
> v10:
> - Return NULL on CAP_DAC_READ_SEARCH
> - Add __get xattr method to solve sepolicy logging issue
> - Drop unnecessary sys_admin sepolicy checking for administrative
>   driver internal xattr functions.
>
> v6:
> - Drop CONFIG_OVERLAY_FS_OVERRIDE_CREDS.
> - Do better with the documentation, drop rationalizations.
> - pr_warn message adjusted to report consequences.
>
> v5:
> - beefed up the caveats in the Documentation
> - Is dependent on
>   "overlayfs: check CAP_DAC_READ_SEARCH before issuing exportfs_decode_fh"
>   "overlayfs: check CAP_MKNOD before issuing vfs_whiteout"
> - Added prwarn when override_creds=off
>
> v4:
> - spelling and grammar errors in text
>
> v3:
> - Change name from caller_credentials / creator_credentials to the
>   boolean override_creds.
> - Changed from creator to mounter credentials.
> - Updated and fortified the documentation.
> - Added CONFIG_OVERLAY_FS_OVERRIDE_CREDS
>
> v2:
> - Forward port changed attr to stat, resulting in a build error.
> - altered commit message.
>
