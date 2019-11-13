Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF14BC43141
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 23:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3BBB206E3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 23:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573686103;
	bh=jgBO/LU5wdjKU5yJf38VII0VsPC1KmmUxj7hMklZEvk=;
	h=In-Reply-To:References:Cc:To:From:Subject:Date:List-ID:From;
	b=inxOBfM5oc9OLQ38dpWqUwyUDRyknno8u5N1v3PmyItrSYK2818hlNQcju/Eosirf
	 CAthR70mCgyDQFDDNLFXHIw9UpjPOi3GFAUBrVOCXJeMTqr4CKh2z2qWz3MTfM+iP2
	 5Q5JDTaDAMHTUbDb0jIYJeaW6GGfzz/3iu+fbfZ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfKMXBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 18:01:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:60708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbfKMXBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 18:01:41 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B770F206F0;
        Wed, 13 Nov 2019 23:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573686101;
        bh=jgBO/LU5wdjKU5yJf38VII0VsPC1KmmUxj7hMklZEvk=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=KZtq2rsSd4M4+U37B1A6tidJf1ptCyUmtn7FoRz1IkRCyW/gj6p6AqrGA4M+QDqjA
         O1Mh365RhLNmy1ftQNyT/guMTFfd7gGHdVcqQebnqQ7zjeZll1Iywl3N5geE1+F3ft
         lhpN0ATdiwE3c4kK0VKHv0u/N33Mf+QnRp//zxuA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191026194420.11918-1-robert.jarzmik@free.fr>
References: <20191026194420.11918-1-robert.jarzmik@free.fr>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Jarzmik <robert.jarzmik@free.fr>
To:     Michael Turquette <mturquette@baylibre.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: pxa: fix one of the pxa RTC clocks
User-Agent: alot/0.8.1
Date:   Wed, 13 Nov 2019 15:01:39 -0800
Message-Id: <20191113230141.B770F206F0@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Robert Jarzmik (2019-10-26 12:44:20)
> The pxa27x platforms have a single IP with 2 drivers, sa1100-rtc and
> rtc-pxa drivers.
>=20
> A previous patch fixed the sa1100-rtc case, but the pxa-rtc wasn't
> fixed. This patch completes the previous one.
>=20
> Fixes: 8b6d10345e16 ("clk: pxa: add missing pxa27x clocks for Irda and sa=
1100-rtc")
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---

Applied to clk-next

