Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0037EC4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C219C2133F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561679533;
	bh=TLxkXBYcOQkQ2yiDZYNy+ckFRMqJ/xF6bF/ER5dH6oo=;
	h=In-Reply-To:References:To:From:Subject:Cc:Date:List-ID:From;
	b=l8EKzboafPNIuGmUaBZYFXPqQFwdT+4bI2TKRiHpp8mC4uGalAwrpiO8vJUxFI+YV
	 htvQbxgrl9c2E99jLsIhy/LSqYfwVLSJjAo0BU6jlqCN9jBoIHX0Pp11BtAIZthqrB
	 Lo7LTzGNw19Ek7wrHJU70eYxJlrKfLau7EiBpx/c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfF0XwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 19:52:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:36562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbfF0XwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 19:52:08 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E247D20815;
        Thu, 27 Jun 2019 23:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561679527;
        bh=TLxkXBYcOQkQ2yiDZYNy+ckFRMqJ/xF6bF/ER5dH6oo=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=brVVYSMICoK5hJs7dp/cs8rUY0QUpRVWtXg25ZwxXq52vfljx9TT0QgDsRoejgLlf
         4QJuOH7kQ5OusWkYZryl5zcVBZmswpFhB4Unz5099QZkzeLozf+kVTfZJeVXqx0iIO
         FFRAtvZJfHgfRH+t8U0NVC+bZMYFqGVF/oaItmBQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190627221507.83942-1-nhuck@google.com>
References: <20190627221507.83942-1-nhuck@google.com>
To:     Nathan Huckleberry <nhuck@google.com>, fparent@baylibre.com,
        matthias.bgg@gmail.com, mturquette@baylibre.com
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: mediatek: Fix -Wunused-const-variable
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nathan Huckleberry <nhuck@google.com>,
        clang-built-linux@googlegroups.com
User-Agent: alot/0.8.1
Date:   Thu, 27 Jun 2019 16:52:06 -0700
Message-Id: <20190627235206.E247D20815@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nathan Huckleberry (2019-06-27 15:15:07)
> Clang produces the following warning
>=20
> drivers/clk/mediatek/clk-mt8516.c:234:27: warning: unused variable
> 'ddrphycfg_parents' [-Wunused-const-variable] static const char * const
> ddrphycfg_parents[] __initconst =3D {
>=20
> This variable has never been used. Deleting it to cleanup the warning.
>=20
> Cc: clang-built-linux@googlegroups.com
> Link: https://github.com/ClangBuiltLinux/linux/issues/523
> Signed-off-by: Nathan Huckleberry <nhuck@google.com>

This patch has already been applied. It would be great if you could try
applying the patch to linux-next first before sending patches to make
sure they're still relevant.

