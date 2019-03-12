Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A2DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 22:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 785F42173C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 22:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfCLWxS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 18:53:18 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:53830 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726402AbfCLWxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 18:53:17 -0400
Received: from mr3.cc.vt.edu (mr3.cc.ipv6.vt.edu [IPv6:2607:b400:92:8500:0:7f:b804:6b0a])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x2CMrG6r007195
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 18:53:16 -0400
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        by mr3.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x2CMrBFZ024414
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 18:53:16 -0400
Received: by mail-qt1-f200.google.com with SMTP id o56so91125qto.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 15:53:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=64oISkUKwQ6vGzVqxptuTsUN3M8UEHXXEaxtfyPdLVA=;
        b=s+thFeWhvbRDXeULol6A4bJuUlyjou3j/5fcc6clZO1hZ5EpDL9WWoHurt91TczdN+
         oekwa3X/YcBLymdaBlm3wlvcqd77sZ/+Yc02mak8Cc9gGakoaOQZGIu6WFTJE3Krpzg/
         YwEcxt5M32Q3ufWq7cBu0LaaasEKUkwsLuUJRKu8EWWyv/T9SuglWjiGeEkv8zwUpcEE
         pD1cl10/Myo3ntgbBN4N/rvFU6SVZhbmaDXj0ks9clyqZvVj8Z65smdOKAD10R/A2mNQ
         yvVTKCP167dsdVYwwv9w3WA1ghvCBHNRqYuN/jQOoEGKm+Sssm4q32zAOcgAznHEOyQe
         3vGQ==
X-Gm-Message-State: APjAAAVtj+AJKIrYQsXblfRs8loedtrwGm+p4f/uEojaEQsiaew96E98
        5JAl9SmhhK6qYLWsoKgvl4lzA+HVsHNV4EN50/nyoK00qw6otnuJpYjhhtcIa3aOEenY06s49hN
        0Ldrp1VAd/SgM6WZLF7SCggvTQr5fUa+Q6Q4=
X-Received: by 2002:a37:4a83:: with SMTP id x125mr30195286qka.30.1552431191185;
        Tue, 12 Mar 2019 15:53:11 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxXBvQrMJuFeAGPiTueEdcGAzd0bFLAl4+TyGAoAwnfcrG5OyGn717owICd29ECpSpfrHCH8g==
X-Received: by 2002:a37:4a83:: with SMTP id x125mr30195279qka.30.1552431191023;
        Tue, 12 Mar 2019 15:53:11 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::3b7])
        by smtp.gmail.com with ESMTPSA id a43sm6871895qta.54.2019.03.12.15.53.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 15:53:10 -0700 (PDT)
From:   valdis.kletnieks@vt.edu
X-Google-Original-From: Valdis.Kletnieks@vt.edu
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
cc:     Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/platform/x86/dell-rbtn.c - add missing #include
In-reply-to: <20190312224611.elsl2buuhkddecih@pali>
References: <17631.1552389966@turing-police>
 <20190312224611.elsl2buuhkddecih@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Date:   Tue, 12 Mar 2019 18:53:09 -0400
Message-ID: <8385.1552431189@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Mar 2019 23:46:11 +0100, Pali Rohar said:

> Can you identify in which commit was introduced this problem? If yes,
> then Fixes: keyword should be added into commit message.

I admit not knowing how long that's been there - I mostly found myself
with a large amount of free time, a good supply of caffeine, and I got
irritated with how many warnings 'make C=2 W=1' throws, so I decided
to start going through and beating things into shape.  For those issues
where I can easily identify the regression point, I will include a Fixes: as I go..
