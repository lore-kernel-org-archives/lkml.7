Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57100C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 326F62133D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbfCRTCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 15:02:43 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:56082 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfCRTCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 15:02:43 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 08FFA72CC53;
        Mon, 18 Mar 2019 22:02:40 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id C64247CC74C; Mon, 18 Mar 2019 22:02:39 +0300 (MSK)
Date:   Mon, 18 Mar 2019 22:02:39 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/13] Prepare syscall_get_arch for
 PTRACE_GET_SYSCALL_INFO
Message-ID: <20190318190238.GB30986@altlinux.org>
References: <20190317232827.GA16301@altlinux.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3lcZGd9BuhuYXNfi"
Content-Disposition: inline
In-Reply-To: <20190317232827.GA16301@altlinux.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2019 at 02:28:27AM +0300, Dmitry V. Levin wrote:
> syscall_get_arch() is required to be implemented on all architectures in =
order
> to extend the generic ptrace API with PTRACE_GET_SYSCALL_INFO request:
> syscall_get_arch() is going to be called from ptrace_request() along with
> syscall_get_nr(), syscall_get_arguments(), syscall_get_error(), and
> syscall_get_return_value() functions with a tracee as their argument.
>=20
> The primary intent is that the triple (audit_arch, syscall_nr, arg1..arg6)
> should describe what system call is being called and what its arguments a=
re.
>=20
> This patchset began as a series called "Prepare for PTRACE_GET_SYSCALL_IN=
FO",
> then I merged it into a series called "ptrace: add PTRACE_GET_SYSCALL_INF=
O request"
> that also contains ptrace-specific changes.
>=20
> The ptrace-specific part, however, needs more attention to workaround pro=
blems
> on niche architectures like alpha, while the syscall_get_arch() part is
> straightforward, so I decided to split it out into a separate patchset th=
at
> just prepares syscall_get_arch() for PTRACE_GET_SYSCALL_INFO: it adds
> syscall_get_arch() to those architectures that haven't implemented it yet,
> and then adds "struct task_struct *" argument to syscall_get_arch()
> on all architectures.
>=20
> All patches from this patchset have been already reviewed, so it's ready
> to be merged without waiting for the ptrace-specific part.  As it's all
> about syscall_get_arch(), it should probably go via audit tree.
>=20
> Notes:
>     v2: rebased to v5.1-rc1, added Acked-by

Apparently, I failed to process the ACK given by Richard Guy Briggs
on January 17th, please also add
Acked-by: Richard Guy Briggs <rgb@redhat.com>
when applying.

Thanks,


--=20
ldv

--3lcZGd9BuhuYXNfi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJcj+tOAAoJEAVFT+BVnCUI4XgQANm0aCspcceM8M/LJPMymiyT
r6amv9IxTIFY8J32TMhTcQDjgbq8qufISs4TR9/oBrLciBsA9MR3gMWtuR3BkdHt
BQoqWFl5Bvnk7ZCoj5bc/hcSKerauIUL5A61yB9KGq7qRgaaAodK7/iZka9yLQHS
cJsyDQQr+SjDp++g10G86gd8ggwRPWbaxJKMsY6R/pj7Pp77N0ngfFUDLYzG2Pgl
t8Sbp/KjqnqshN7xrovn2pdOVKydfT+8chOjCb5YfTgXqJpAEtto8jJWMqflfXgI
9jkIkQb/RBysUMPg/Y/5+y/h4x5fLB3XehEASyR2iYLwGzDYK9gSZZAPPPOC8vai
B3U6CEiXelGLAVzDmFEkz8slmXuJ5JYhdJk5urEs3cjKk4Ythja9qJk1Hd49kiYi
4eIQnupbZhHfIOByAzY/1IvTvasHCiC6Nnpc5b45VHEV5qEbFy5oXS1tu1UJNjog
fTVmTur0aRoNgnXiB7AZeXp0LwqLwOa9uMchrsX2WtJr64FK9nk8vIgottiztGqw
3SOxSwzAZPxGHwiEhWFj+HaMx00eeoi3YR7XL5nEJYjMTa7iwHpBHP7nfyW4zRMS
zSS9AzNSlnObmRyBoB4TVZ17RYjHdw7OHXcsWart6QuKbPXy6L/dh+ZVo14I0OUL
/EBkcDN0vykM+GdApqwc
=CYWQ
-----END PGP SIGNATURE-----

--3lcZGd9BuhuYXNfi--
