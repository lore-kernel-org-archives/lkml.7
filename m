Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B82AECDE20
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 10:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42AA720CC7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 10:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=labbott.name header.i=@labbott.name header.b="IvFzUB7W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbfIKK6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 06:58:47 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:50253 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfIKK6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 06:58:46 -0400
Received: by mail-wm1-f46.google.com with SMTP id c10so2894972wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 03:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=labbott.name; s=google;
        h=from:content-transfer-encoding:mime-version:date:subject:message-id
         :to;
        bh=lemYNYtgToTykhs7Hiz/YSCcKOw/D2ARLV0H11ZZBBY=;
        b=IvFzUB7WwNzJRlMhu8byrfbS8LXHYPxcg0v3HICGqp4Cvf/Ye460dAGdm6RKKqaE1N
         9Rb+YDOHFnrHRBfMc8ImaTvXYe8H75QzuQ2DhP+orG8BUEGv/oUV+8NMsFov3nMvoI5f
         +948wrbtZlM1LzHUmq++uYr52hQLI3mT1OmKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version:date
         :subject:message-id:to;
        bh=lemYNYtgToTykhs7Hiz/YSCcKOw/D2ARLV0H11ZZBBY=;
        b=EtFjZj6NpbgtV2VbdhVKETLWq45BwQL0MacTCv6+7GD8KhVFaC6+mZUuUgXoBQWbGL
         mxgB//4wFk5pI73Oj1ZwwFsIVIWUxEpx7LYn1tPW9JOo+6Edz0RGSIMbHsSYLHVyCkGu
         Pw25titJVhoyUMTfkYx63eUukVu0YHNTBEqW2oC9JQvMCCKmIE0QBEUCGwVFYt8BLwDp
         o2iFvXkVVZKdSQWCVUH9lBysO51zYgESAvyJFCqJ77HZZ0hX1/LxoYznIo2CYCoybU/c
         lyp3Mr2UzQCVmmX7lj6d4xbveDqwD3bJPoJy6Av0tyHsqe7xtFWe1e9+/SeBMLGnHDKB
         G6aA==
X-Gm-Message-State: APjAAAVnp+7qZaano/oR9V/tFX0vlCeRDCZmx0EoIOBT9rVeCULYNSrv
        b6oXeFnIVTewcpmAtR4gvfXLj/EHBdFEjwi3
X-Google-Smtp-Source: APXvYqwL4TtccIE8dhvRYLYt0IBVInmLIOqgs4VNLbtCgIQeCotJUztSLQmt5dQq1tsQ1g3P6oe2vg==
X-Received: by 2002:a7b:cc13:: with SMTP id f19mr3575179wmh.141.1568199523816;
        Wed, 11 Sep 2019 03:58:43 -0700 (PDT)
Received: from [10.93.12.198] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
        by smtp.gmail.com with ESMTPSA id b144sm2512313wmb.3.2019.09.11.03.58.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2019 03:58:43 -0700 (PDT)
From:   Laura Abbott <laura@labbott.name>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Date:   Wed, 11 Sep 2019 06:58:41 -0400
Subject: Results: Linux Foundation Technical Advisory Board Election 2019
Message-Id: <8DB2E3F6-F5E9-4762-B19E-332C3B313ED1@labbott.name>
To:     ksummit-discuss@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following are the results of the 2019 Technical Advisory Board (TAB) =
elections:

1. Greg Kroah-Hartman
2. Jonathan Corbet
3. Steven Rostedt
4. Ted Ts=E2=80=99o
5. Sasha Levin

Thank you to all of the candidates for stepping up and running this =
year. We
appreciate your willingness to serve the kernel community.

We had 174 people vote this year. Because of the way CIVS works, we =
don't
have the full count of votes for each person, only the aggregated score =
and
who "won" against each person. Results are available to those who are =
interested.
A big thank you to everyone who helped with the electronic voting this =
year,
whether participating in a test vote or proofreading my e-mails =
explaining
voting procedures.

Congratulations to all the elected candidates!

Thanks,
Laura=
