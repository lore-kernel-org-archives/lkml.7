Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CBFFA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 15:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16FC82067D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 15:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390112AbfJPPQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 11:16:19 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46923 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfJPPQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 11:16:19 -0400
Received: from [213.220.153.21] (helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iKl25-0003hT-IE; Wed, 16 Oct 2019 15:16:13 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20191016150119.154756-2-jannh@google.com>
Date:   Wed, 16 Oct 2019 17:16:12 +0200
Cc:     <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>
To:     "Jann Horn" <jannh@google.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        "Todd Kjos" <tkjos@android.com>,
        "Martijn Coenen" <maco@android.com>,
        "Joel Fernandes" <joel@joelfernandes.org>,
        "Christian Brauner" <christian@brauner.io>, <jannh@google.com>
From:   "Christian Brauner" <christian.brauner@ubuntu.com>
Subject: Re: [PATCH 2/2] binder: Use common definition of SZ_1K
Message-Id: <BXR1QBD488K5.2PSZLBF2IUDKJ@wittgenstein>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Oct 16, 2019 at 5:01 PM Jann Horn wrote:
> SZ_1K has been defined in include/linux/sizes.h since v3.6. Get rid of th=
e
> duplicate definition.
>=20
> Signed-off-by: Jann Horn <jannh@google.com>

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
