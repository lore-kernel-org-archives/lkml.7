Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C64C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 16:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C48DE2080C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 16:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvYPoeRR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfFZQtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 12:49:17 -0400
Received: from mail-yb1-f182.google.com ([209.85.219.182]:36054 "EHLO
        mail-yb1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfFZQtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 12:49:17 -0400
Received: by mail-yb1-f182.google.com with SMTP id e197so1706449ybb.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 09:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=YDfda8j5Vq3jUVW8ct19lcFoprE+bnuXhz+JGmBfFQI=;
        b=TvYPoeRRD8T/Sa+ku3PJBE4ai0GhU+YXKWJpchlRg2FzLUOZAL4g4eFcgydweA6z2x
         Gk7IQAIVb2Na4LBxu+H+y7bw2i+Yyq6rtgi0mdV7ZNcDHMz32uYHyExn0rUsYiW69Wyb
         5V93o+tP5uIgLUsTCcCuB5YHG+HYYKJ48FdsJnTfGfQiuuNizNSE0azsgpAN/VhfwFap
         hKprXY3OdqPFGoN8Jxw/RzRWz6mYOwL/deChhzjeKfB3YEPhvTeT6z4N+qoiI0CSDL0I
         2cI141TXV/3IJQDRW4RTx1e79jPyrjo7MLFM37woZZbkECV7vVBfOjlG/201xukZlfmh
         qeFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=YDfda8j5Vq3jUVW8ct19lcFoprE+bnuXhz+JGmBfFQI=;
        b=YrpL9izuBydGEoE1wPAMoB2J8pnagu+DCd7L49VJeWAPHIDtNMLm9gc0nlkgchyKH3
         vmhVDiTBfqSTs4JZ0pzlcEcVuL5jSkDCFkq1NtS30thYaUdozfLrEGwX0I7xM50oe7QR
         N1aF+V3rTEXWcMFzVnNTtNjMRsgdwexlwLNXo0sF26zESBup4gHYzbJp+3Zr1Sxl2pos
         9kyFXqllKgjot2kHQ8gNRRJt2DZ+vsTIVC5tI7HTtVWPs/NP+k+7GXnfXpw/b7GRO9rQ
         OCoHUvL4AXYh+KfYpIZDpVuAJWllIieFt/gNSNFJrbZNdcT3fwyp0KE4UCCgkZs06DNo
         vW/w==
X-Gm-Message-State: APjAAAVtnoVMmOWaR5bLUJ1uprnqgHYXCZAWeeJzNlPVolc/7GHG+4q9
        jnoy8T8bnY9axIGPSgzLsdCK3yL4PLnuuPZWOocpbWc=
X-Google-Smtp-Source: APXvYqzddVNh507NW54e6/RFy0h/UqhOhXq3dTZlrRQJCskOV1xggIfTrE0d8cc5MSco/l51q25Fk/d1RjhQTioizr0=
X-Received: by 2002:a25:6c82:: with SMTP id h124mr3502355ybc.55.1561567755979;
 Wed, 26 Jun 2019 09:49:15 -0700 (PDT)
MIME-Version: 1.0
From:   Turritopsis Dohrnii Teo En Ming <tdteoenming@gmail.com>
Date:   Thu, 27 Jun 2019 00:49:03 +0800
Message-ID: <CANnei0GBx4q+18qzTLeaRKX302ntARbfWQwEfXDUBsFWnmfvvA@mail.gmail.com>
Subject: Facts in the Singapore Political Context
To:     linux-kernel@vger.kernel.org
Cc:     Turritopsis Dohrnii Teo En Ming <tdteoenming@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Link: http://lists.linuxfromscratch.org/pipermail/lfs-chat/2019-June/029016.html




-----BEGIN EMAIL SIGNATURE-----

The Gospel for all Targeted Individuals (TIs):

[The New York Times] Microwave Weapons Are Prime Suspect in Ills of
U.S. Embassy Workers

Link: https://www.nytimes.com/2018/09/01/science/sonic-attack-cuba-microwave.html

********************************************************************************************

Singaporean Mr. Turritopsis Dohrnii Teo En Ming's Academic
Qualifications as at 14 Feb 2019

[1] https://tdtemcerts.wordpress.com/

[2] https://tdtemcerts.blogspot.sg/

[3] https://www.scribd.com/user/270125049/Teo-En-Ming

-----END EMAIL SIGNATURE-----
