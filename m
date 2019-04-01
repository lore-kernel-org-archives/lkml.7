Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BAFCC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 05:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC267206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 05:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="oE/ljU5P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfDAFTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 01:19:07 -0400
Received: from mout01.posteo.de ([185.67.36.65]:48062 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbfDAFTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 01:19:07 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id A2FF1160061
        for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2019 07:19:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1554095943; bh=aVFCt6a1dbisC3syzvWtYptENjHcG3Q3x9DkxFM51uU=;
        h=Date:From:To:Cc:Subject:From;
        b=oE/ljU5PdyCGFRJwlhdu4tigO8bQrDHkWibCzts0Y8hK3HgQN58Jo2rHviIGEW8MY
         VewFuWnY1/i6J9uJf6d5+RO0kk16ClRlfLCbrnL+jzITSSo3Dnq8SFud0/8eSPVoo/
         OnzyKYoG9YBxIip/9zEsglANKGy0PVYrEqusr64iJ2JESyylDscuB/sYpwSWnAHUg5
         oTTJzsnMZsK95uWfe5lbpMIiL4nCBNf1yrO0BmOD+258mVJ1rfw3f1+Nx7Zihr/IV3
         2h7q4SLveA3O7ypYW2dtM0ikvGW/zUZYUaW5mDKWXQa7KXk5q/svcMGrPubaUQLiUo
         POFbGOV1jeLGQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 44XgcQ4T5Tz6tm6;
        Mon,  1 Apr 2019 07:19:02 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 01 Apr 2019 07:19:02 +0200
From:   Martin Kepplinger <martink@posteo.de>
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: kernel-docs: Move vfs.txt under "Docs at
 the Linux Kernel tree"
In-Reply-To: <20190331221439.22892-1-j.neuschaefer@gmx.net>
References: <20190331221439.22892-1-j.neuschaefer@gmx.net>
Message-ID: <423faa6a06fee4e1106f8b0c83bcd78d@posteo.de>
X-Sender: martink@posteo.de
User-Agent: Posteo Webmail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 01.04.2019 00:14 schrieb Jonathan Neusch=C3=A4fer:
> It's unnecessary to point to an external mirror of the Documentation
> directory. Also, drop the date field, because in-kernel documentation=20
> is
> continually updated.
>=20
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> ---
>=20
> Alternatively, we might drop this entry of the list entirely, because
> Documentation/ is already covered.
> ---
>  Documentation/process/kernel-docs.rst | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
>=20
> diff --git a/Documentation/process/kernel-docs.rst
> b/Documentation/process/kernel-docs.rst
> index ab12dddc773e..92488e59943d 100644
> --- a/Documentation/process/kernel-docs.rst
> +++ b/Documentation/process/kernel-docs.rst
> @@ -52,6 +52,17 @@ The Sphinx books should be built with ``make
> {htmldocs | pdfdocs | epubdocs}``.
>          (including this document itself) have been moved there, and=20
> might
>          be more up to date than the web version.
>=20
> +    * Title: **Overview of the Virtual File System**
> +
> +      :Author: Richard Gooch.
> +      :Location: Documentation/filesystems/vfs.txt
> +      :Keywords: VFS, File System, mounting filesystems, opening=20
> files,
> +        dentries, dcache.
> +      :Description: Brief introduction to the Linux Virtual File=20
> System.
> +        What is it, how it works, operations taken when opening a file=
=20
> or
> +        mounting a file system and description of important data
> +        structures explaining the purpose of each of their entries.
> +
>  On-line docs
>  ------------
>=20
> @@ -95,18 +106,6 @@ On-line docs
>          [...]. This paper examines some common problems for
>          submitting larger changes and some strategies to avoid=20
> problems.
>=20
> -    * Title: **Overview of the Virtual File System**
> -
> -      :Author: Richard Gooch.
> -      :URL:=20
> http://www.mjmwired.net/kernel/Documentation/filesystems/vfs.txt
> -      :Date: 2007
> -      :Keywords: VFS, File System, mounting filesystems, opening=20
> files,
> -        dentries, dcache.
> -      :Description: Brief introduction to the Linux Virtual File=20
> System.
> -        What is it, how it works, operations taken when opening a file=
=20
> or
> -        mounting a file system and description of important data
> -        structures explaining the purpose of each of their entries.
> -
>      * Title: **Linux Device Drivers, Third Edition**
>=20
>        :Author: Jonathan Corbet, Alessandro Rubini, Greg Kroah-Hartman
> --
> 2.20.1

Reviewed-by: Martin Kepplinger <martink@posteo.de>

thanks

