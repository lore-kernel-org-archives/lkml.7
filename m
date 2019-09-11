Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A30AC5ACAE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 12:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1375206A1
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 12:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=aurabindo.in header.i=@aurabindo.in header.b="CTye0k+P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbfIKMyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 08:54:19 -0400
Received: from mail-40132.protonmail.ch ([185.70.40.132]:20777 "EHLO
        mail-40132.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbfIKMyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 08:54:18 -0400
Date:   Wed, 11 Sep 2019 12:54:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aurabindo.in;
        s=protonmail; t=1568206455;
        bh=/3BZ39augr1ATxiyl7hnoRIDGLBNGu5l1MgK7F7Oyjo=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=CTye0k+PE/+xBZIyKanXphQXS5P9TX4t6lty9PQYhv113W/RXzTQcdN+7lAUC9L3c
         3fzVwV9iI5nNcTsJEBLV/2rSrJkm/EC8v/zbw1MnY5FNZy8j1r8Nlu5EPxebZoWek3
         8KxFe+lCdyABaw69mDkNnLQEbijbzLiTYVxMCjbY=
To:     Troy Benjegerdes <troy.benjegerdes@sifive.com>
From:   Aurabindo Jayamohanan <mail@aurabindo.in>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>
Reply-To: Aurabindo Jayamohanan <mail@aurabindo.in>
Subject: Re: [RFC] buildtar: add case for riscv architecture
Message-ID: <X9f9LozkDQUeBwasTsPlPseP6ZT5yJHNY2GcIgoAgNQJPuFAyYimnDXTJUqxfrZ64GOIl5-uPh07NZnD1pi4uWhCpZvbu9khOW6rEq5P4jU=@aurabindo.in>
In-Reply-To: <8EF02DA7-46D3-4EA8-96FB-27708BF25DAC@sifive.com>
References: <NwVOGH2ZdDQaDK35QUy7y8GS__G8IYSIUUIBAJsimZq5BgvI3SzLS3uY6fV7Pgppq-RTRHzpT-8KrsLjDN74CPWwHTCWoSgHkGbeJNvyS30=@aurabindo.in>
 <8EF02DA7-46D3-4EA8-96FB-27708BF25DAC@sifive.com>
Feedback-ID: D1Wwva8zb0UdpJtanaReRLGO3iCsewpGmDn8ZDKmpao-Gnxd2qXPmwwrSQ99r5Q15lmK-D8x6vKzqhUKCgzweA==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> None of the available RiscV platforms that I=E2=80=99m aware of use compr=
essed images, unless there are some new bootloaders I haven=E2=80=99t seen =
yet.
>

I noticed that default build image is Image.gz, which is why I thought its =
a good idea to copy it into the tarball. Does such a copy not make sense at=
 this point ?



