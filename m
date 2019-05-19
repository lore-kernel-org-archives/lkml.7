Return-Path: <SRS0=AA30=TT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2E9C04AB4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E5E20675
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="TnCPjyTJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbfESR5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 13:57:45 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:35307 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727456AbfESR5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 13:57:44 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 456KzD0wGPz9s9N;
        Sun, 19 May 2019 21:48:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1558266489;
        bh=dcC4Pl+dHTN4EvIbHGnWnpvX6DS3gAolTE3f1YRjrzY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TnCPjyTJKKehfukzj3YXNqKAv0YWzLCmXdxeqUvfUMPt7/kwhq+W8imQEkKDZRi1J
         145c4USmrWAWlzDtyB+ZHrw51yvM30n18+r89fYnrEu94CdvUWQp1XiwVxDbwSGcsS
         hJktgFqQcCAFZaaLR5UchBV8+FJ69xg83BRBDTdcEqpSZUKn0NBPQYOidhyOr+xeC2
         zToVavSokFd1ZKj4165ksjGo5fksPa+xesicy+97csBV32SZlbsBMIG6CFWEfObMqS
         g9sPYD4Y/wn+0E6JHp99j9Yr5dclOispVc7RK7pydBsf+4U/unn/DrrhrMs88iO13/
         cuOZoPyItvHnA==
Date:   Sun, 19 May 2019 21:48:05 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Junwei Hu <hujunwei4@huawei.com>
Cc:     <davem@davemloft.net>, <willemdebruijn.kernel@gmail.com>,
        <jon.maloy@ericsson.com>, <ying.xue@windriver.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        <tipc-discussion@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <mingfangsen@huawei.com>
Subject: Re: [PATCH v3] tipc: fix modprobe tipc failed after switch order of
 device registration
Message-ID: <20190519214805.520960ec@canb.auug.org.au>
In-Reply-To: <529aff15-5f3a-1bf1-76fa-691911ff6170@huawei.com>
References: <529aff15-5f3a-1bf1-76fa-691911ff6170@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/.5WpHUFo45lAAiLWKH8ATXt"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.5WpHUFo45lAAiLWKH8ATXt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, 19 May 2019 17:13:45 +0800 hujunwei <hujunwei4@huawei.com> wrote:
>
> Fixes: 7e27e8d6130c
> ("tipc: switch order of device registration to fix a crash")

Please don't split Fixes tags over more than one line.  It is OK if
they are too long.
--=20
Cheers,
Stephen Rothwell

--Sig_/.5WpHUFo45lAAiLWKH8ATXt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzhQnUACgkQAVBC80lX
0Gz93gf/Vl/AGezDCSew9ABACA7mqAhzq73iHXkBVJFBpNUTn8crMYerkjeykLnY
5Phbbqa41q6jAt9zw0mPS808Xx5pkkI8sg+JmCXe6bSxvLd5WMZAF6j10ijNk5x8
HzwHEoXHg+wfh4hh8MDPXAIIYjkdgPgu+euSivoxjWBiZWL6qk8BMPMK/JR83M/f
GVxOFsjAtXYJTA0Dubw4jY6so0VSwyuYqMQ5DJ7tG4uWetoSyIf+86FqGIjXBwW/
IBYQA2V3HI6xoidvK4+4J/9l/Y1nMi4dbQBD1qz6mnCb39T95bMJeLbHuYdv6JZd
Yp+0FPJiJjzJu3NOD2RIDYMmeTeVeQ==
=KmgI
-----END PGP SIGNATURE-----

--Sig_/.5WpHUFo45lAAiLWKH8ATXt--
