Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E21C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 20:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89702205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 20:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="NBiUx3ox"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbfDWUzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 16:55:12 -0400
Received: from mout.gmx.net ([212.227.17.21]:42303 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbfDWUzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 16:55:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1556052894;
        bh=MMtRNhuFXEBZSkZYV+kLiMCuKXP7w+2K18dCqCisgQk=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=NBiUx3oxwp4gGSgEth020SJWirCoQbU1Z5tsHn8rakwDPsDfAuzOcCaABRxkhhP6r
         p22Bx/84HuidEpqS75CyE8q+2XTwIaak9IcuSyMuXVImXgNxPWzd7SE+qkjpOwi5Lf
         XdrHkzzcbnDDoUQv87WoWyZojn611hsh+vnoGEEY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([77.247.181.163]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LvDpe-1gs7dU09FS-010KHi; Tue, 23
 Apr 2019 22:54:54 +0200
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Thibaut Sautereau <thibaut.sautereau@clip-os.org>
Cc:     Tadeusz Struk <tadeusz.struk@intel.com>, grawity@gmail.com,
        James.Bottomley@hansenpartnership.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Jonas Witschel <diabonas@gmx.de>
References: <155371155820.17863.10580533125620125669.stgit@tstruk-mobl1.jf.intel.com>
 <20190328123428.GF7094@linux.intel.com>
 <b29aaf62-2ea0-d6c6-32ee-44bc3fe8f03f@intel.com>
 <20190408120138.GA951@gandi.net> <20190409134421.GD9759@linux.intel.com>
From:   Jonas Witschel <diabonas@gmx.de>
Openpgp: preference=signencrypt
Autocrypt: addr=diabonas@gmx.de; prefer-encrypt=mutual; keydata=
 mQINBFtc1v8BEACwMyEEHmk3dOPRMCKA/o3OvL+TSorO4j7/3lHC31gLTYYXRXM47tqm8tjT
 pamOzWoS1Z60XO31u+/BwRMBXUC3mCuhind5NBPQRX51DYqRVF9z5dXAzWXcG1xEhTI0IEH3
 WJ04U8XA/5UJ6Ok/dBeJm0nCeW7SrJMMUm7CEps81M8+MYANteZNL3psVFUSfFsnM/euc8lq
 pkJOy3+RaWfvTCtY2vgR9WJvwLtpAJcLzcsmRmYN/CrWs40QnwD7cYhm+AcOGUPmEAfUI7L3
 b2veuu2GHtYj2tJ4ba+gBZfACTkFDnpBS4L+bBQzFWjXnvJLfCHLAu2Qf2GMO7Y3YKAvCipM
 VTG9IPXYUtbbrNXQWJQJ91dWSmijqfeDmgCqXBojWLSlK5Yc6HpCQKCqj86Hk0oJ/S0zM4Y9
 rGmQ2NMUuGHhKWg0k4/qSLESPHLRnX7aC8i4/EBnE9YjeKtUEp1hqsRrDp1/1bebgysreaDz
 McX10iG3iBVl2jaxKkZ/kH11Uc7ILys3SWQ10wBIhYj/0XZmPayTKIoQGtrghhINUNoHV++g
 8gAiozAqA1u1ivL3NqKuRcQ0pZOYAlTv1hkx7De5KIr2BVaTv3LQLNLiX6WygkkpGU+FM4Hz
 C0GxdfrseLodpjzJmQjajRXryGKf2dBDcxHnF2ZKdgxv1D+VmwARAQABtCBKb25hcyBXaXRz
 Y2hlbCA8ZGlhYm9uYXNAZ214LmRlPokCVAQTAQoAPhYhBDvqKqVfGSfIsrO6QB5YTbcW76yZ
 BQJbXNb/AhsDBQkDwmcABQsJCAcDBRUKCQgLBRYCAwEAAh4BAheAAAoJEB5YTbcW76yZyTsQ
 AI8zDUvEMDiXLoXd2QDoN8yqFZM9wRMEF+FQhs+YUHC5VctrkdmcyiXKMKyi2xnCx5a6vvJz
 2Lag8NghYLUZ2gWFXzWZFnWsudi3CmPyU4qRfIfB1CwyYs7SjdNk5Vi9FlJ3JaDSRStThXO+
 NJfDyjI1f2kvoQXhDOw43tYzSFrqeaIABonrmjZ7kNWZ4YrHh9TNR3k6oAKhr7Uyntu2bRCh
 LjclADX55/aHCez4sE0Mejp2pqUwLiMv1cReReDEYnezYGr8+nyUQMwF5wA6kBT9W6Wr/uAd
 vKXYDgwuoyMpiQWGJWJcKe6WZ39JKUZrgPKQ26jDJQ4uRPGgzdfSsMXivLQNFtSoNeKcdgXT
 H9qrheqbNlpRv6cT4HmRgRPOGNmWGUOQz6AmUrCJzETKrQ/ZrUkeJA1xuCA8YpHSqLPURny2
 TOco9AqTaNbXMwm9iyTbfzlVxcuM2BD6Ekr1vaOOOJfWHPUmEQ4AvD7IGgdjz0k/UvQRbaM/
 gSOHtkcVRWsHFP7S/Yv//tISi/jGTFZp36hfYOMHHz48ORY4aPZkrEk5AdHL703pgsvvRQQP
 YdeW/zoQVM53iiOmQMcegNf8lij63ylPtVtCyt/cQ8SY2XG+UboLR/rjsfq49UEvnwHF7K1q
 pVUCZI1CGJgnKesag4OMr0g0V2aJkAW279tNuQINBFtc1v8BEAC8oP9mDxbSgLca+EMnwdlc
 u+fHew3lTx2ODJa81OfTwnmsU6UaiGUeSi2CUxLUsjwQRuNunni+GDgLWDYFmj7Lhowsw0uG
 jTlV1z+hUpqmcuVsgqGGMKvYVDKXN35UwX7hFEZvqeTkE7fgv9JvvuUSUj8nUFrUK8pnzjRY
 RsRmVSbu/UHOd5FFC9UpC3+NB9+o6GXcUYK+gHw7rD8SiuVk1kASghrcRNjZ8rolKIpXX+MV
 wb3bdTBk15KwggUcLw6Yl6ObZ4XglWdV3HfIoQ7LMvZOYPhW6Cf0in4VCjsAdoLb/1NXxawV
 BBTYyg+/a1lChLMGgplZly1+uCs8Z2RqlwOyN2fj7WyTCB2btAIRaPl/2pvosyWOKaeHHpLZ
 +1trrJiEyj6K3HKBZ+PgkOmM1on2W7r3qMBJPCX3a+UhHdL+Y3ziKn6LUBFGL1E8ryrIMVJm
 vRQJlAGbLscovjlYIawMWNMbt6lYcNxmHI3E78t0x6Ua9hfVTALlKzshQ4ui/GKyREPYFG9J
 7R14XuEzR9LYXwdT2kvlDEVGteznj+qWkqz0Qq/RQ+oD9gw5R9aRpAmJQqZhVnUGwmjesw7y
 E9hP2JDBCs0uBEKrcKyiX+ITtncVT4IRGX51floIM0bpRwOoTAtO492vs7EjiK/ag4PgNx07
 bgYKfSuqvnSGvQARAQABiQI8BBgBCgAmFiEEO+oqpV8ZJ8iys7pAHlhNtxbvrJkFAltc1v8C
 GwwFCQPCZwAACgkQHlhNtxbvrJnXfRAAi6PJN7I7fesqRhxtYTr25OviisP0AnC3ztjzyq2u
 83xlcO/T+igZlmcln9OaWkjhn/LolRaJUBeV6Q/voSZvYoNoLhD1lQ3B1IRVgN0lzhFH1DcD
 +t4ohWR5lgT5m8TBHREzaabO9Up2Pl391pCq2u9BxObaLMiAxeQgsZwiLBoA/btFXKFJPImS
 u5EpEex7zs9bdgE604qJ6sRQGfY7EySXYri08uMNG/h31sbossi8qwpq7KtK+hsCiR9IPRJ6
 alyWkyJlMjCCTWX6BVYkW2S7khcHSbQyvXbzYVd7HOjulJh/zi6oX8ef8zPZDRbg4rVdoHHy
 /A3Sun9AoDKMcKj0f3wY1ZYG/WoSad2VGWbVyxXCNXK9ufugLYiy04sH7UTzLeQhggT60/H+
 qZIvFDl9WgJi53V5wWIY9qBekQAH75VPG/bTfYkw9n7+PQHa7Nsv0vc0Q0nHjqM9oSkZBSIr
 crVDi6BzW7SRGr7e07nVQS9aJNZQSq3JsXkPK81Nv6Ybh5w06EHVNGZPDVWnAP4B9GoB0SKK
 D3GMlpJuQGJ10cnTAS8GgfzX//iZPHP9awq3KB46LQmvrSQN9+g04jnavNcLmIju6oiqb56b
 XscGjST5vGCudHa6+CTYcc+Yu86v9dEMCs5tyZBx9bY2JAdTIFAMEqNbDsLURrHDexE=
Subject: Re: [PATCH v4] tpm: fix an invalid condition in tpm_common_poll
Message-ID: <e9cfa3db-42d7-4e1c-a371-2c810f911dab@gmx.de>
Date:   Tue, 23 Apr 2019 22:54:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190409134421.GD9759@linux.intel.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="cMYqcexaxgtgboTA4SOZte4nVhmllhyLa"
X-Provags-ID: V03:K1:uhIkkEo8nLjwWVPH8PAa0Fg9TOYq7X/ulM9W+dHF+65XWtlPmiL
 34w1M3UpKnWT26bz3F5tdmbnF5Exy0IJoY55+r4WQdDu233D+HhF86kyh8Blakla50kCkbn
 s8XkzVsQKHWnjsqvdUsySBv1oFeQ3O0l1PS2Fr+XpcfIiSXecNxrY7cG5WAQwzC1bI/uJ11
 ImLTzQ1Jr7ov3A0A/5udQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bwZgQiCW8ZM=:uICizMWANjEMr7+IjXxXO9
 QKby1N9X59eicKd9sAhuIKPK3yFkpb+9Ax0ES1T7tlj/dhXL/y52UdpPUZkYYl6pe2SpxfNuN
 PQM4lGKUHsHGqCPdpi8nvtsntFjCHq2rhZD8vUuq8YC6SB9gMZYvb+C1FksDBRfqPHFe0QsPc
 Q+c/LkhO7Ttl1oBy+4DUYHYrYscpP7cHmz+x0H2aAN3cMq7LBOz2GL2EyztdvgcJ8EWWANIa7
 sSRZNrOYKi6iWPLfr9Z1o6QXauH/FGvCD8ubFpN4SE/l7iU+sk/WEIrMDkskQxp3xmhN5bqWx
 B9pY9PWwzXmd3M2XsKfyLvSuDmi/qI2T+hEtCREAKWXV/aK92UJoQoXKBot8Zp8Cq55f6Xtho
 hdll35j0a9wWvVjUjTqwI35hM22jXU7BvezZtBTGe9XkNcF0X6dK0ew5gt8xUyE4vVz7jM5nA
 DLi32uLPM/nnPgtFOUe9Eeij51ja4DFsFahiqlVcBTn6+xuP3VOpug4NhY5WmnkAKh3rSkqnb
 MxED/9blAOMzi+fpoqmoxGPFytHKhUToFQU9jEv3mCOIVk0XGAVd+jTKP8GdX191ceo7MAtrp
 0KQZCafvBRPTvdzhnVjsKlPIxevD/OVsU5t39BSB2P0ZpxZBC0RplsjYMLiIDmuf7qaVumjff
 XERTyfP8N6xUiuBMbVDojWEsysJg3HXPARXuwijcwej5baeX8Xw8JJkGmsekFcCL0iAqAZmO4
 YYv0mwarwTznwP8Jphc9fRJ7Mh9FLvokd/z3PYdUPmqcRvAE/l5U2Z6hVM/tM61wFyS6J3Bnq
 8YGXaou8Fhad1FN//R2pHXf/PSS5ARO/ztW3rDw0b0p/qHrgojrCEINkwX7Qd0d0qsZVdVgd0
 odAtxOBZCR0Y2PrC9xE52JvVf/+TzVx/GVA2ycoYDFZef72dHPTWPSQRa22Oz1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cMYqcexaxgtgboTA4SOZte4nVhmllhyLa
Content-Type: multipart/mixed; boundary="7LZjjByry09BVPUEdJQa1ROgWooUgBbu3";
 protected-headers="v1"
From: Jonas Witschel <diabonas@gmx.de>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
 Thibaut Sautereau <thibaut.sautereau@clip-os.org>
Cc: Tadeusz Struk <tadeusz.struk@intel.com>, grawity@gmail.com,
 James.Bottomley@hansenpartnership.com, linux-integrity@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Jonas Witschel <diabonas@gmx.de>
Message-ID: <e9cfa3db-42d7-4e1c-a371-2c810f911dab@gmx.de>
Subject: Re: [PATCH v4] tpm: fix an invalid condition in tpm_common_poll
References: <155371155820.17863.10580533125620125669.stgit@tstruk-mobl1.jf.intel.com>
 <20190328123428.GF7094@linux.intel.com>
 <b29aaf62-2ea0-d6c6-32ee-44bc3fe8f03f@intel.com>
 <20190408120138.GA951@gandi.net> <20190409134421.GD9759@linux.intel.com>
In-Reply-To: <20190409134421.GD9759@linux.intel.com>

--7LZjjByry09BVPUEdJQa1ROgWooUgBbu3
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB-large
Content-Transfer-Encoding: quoted-printable

On 2019-04-09 15:44, Jarkko Sakkinen wrote:
> On Mon, Apr 08, 2019 at 02:01:38PM +0200, Thibaut Sautereau wrote:
>> [...]
>> What's the status of this patch now? It's needed in linux-5.0.y as TPM=

>> 2.0 support is currently broken with those stable kernels without this=

>> commit.
>=20
> part of a PR.
>=20
> https://lore.kernel.org/linux-integrity/20190329115544.GA27351@linux.in=
tel.com/

It appears that the final version of the patch that was merged to
Linus's tree [1] does not include the "Cc: stable@vger.kernel.org" tag.
If I understand correctly, this means that the patch will not be
automatically included in the -stable tree without further action. Is
there a specific reason not to apply this patch to 5.0.x, or did the tag
just get lost in the merge process?

Cheers,
Jonas

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D7110629263469b4664d00b38ef80a656eddf3637


--7LZjjByry09BVPUEdJQa1ROgWooUgBbu3--

--cMYqcexaxgtgboTA4SOZte4nVhmllhyLa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO+oqpV8ZJ8iys7pAHlhNtxbvrJkFAly/e5cACgkQHlhNtxbv
rJlF5w/+LViXJaVZQKOa5LlhDqdkVuknYUwIZknfp8VQKpVX9mbEbzUsngHzE77u
dNTt2A4xamy2Lg5H2mYHcRUchxMjBEgqS8lrH+A4WPeZMR5x9EavgIgq0ZY9Bu5/
mJgK/AzQWu2HvGNt2Zi+K2lo0zOO+VOdUY5l4O62ttTzVO/7GKMU0R51mRMUZig5
LyeH0KDWea/shdmcg/k88A5NGA40Gf0DbRws/gRwTjK85h05v/Y7w1uVghcmEmXb
3SBqw2YX5XOeezXIDLlNo/3iUYwnv/+dwqAtwEQOPkCHVtQvPKi//+vIygfBZjXq
epj2+HPY4d9u24Uv30KjS0+7PyVJ2aOCeJbPcNfana0VF193/YVRcBbpZYSPgEPC
RTYgjxekHhF2d4R5rlS2ioG+4G2808KT+Ki7ZmJ3tYgPy5PbiKsLKlCfJWM/efES
KVhne9ToOGfBXrYoytMGLuYrCSfuNA3jVuBJvV9QigU8OVzbETfYcfz7YWdukCBE
BzX3krBUk1lYoYBetI2Wq1rIoTQmgyinzFz+ZgGaR2PiMCy+nWYK93X4Mpc7Y+mo
yGMRzrEklYPKkhy2w25/qRol8zTn8aWQKKr4IJfLwvoJ43ajZi0IlGBwWbBX0i5I
d/7pBGb7hApx7gFK5vyujcJIaLRal769DJxzKORwO2eNCniCVMc=
=m9y8
-----END PGP SIGNATURE-----

--cMYqcexaxgtgboTA4SOZte4nVhmllhyLa--
