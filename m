Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF998C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 992D121783
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="H7N5Qr51"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfKLLm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 06:42:28 -0500
Received: from mout.gmx.net ([212.227.17.22]:38379 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbfKLLm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 06:42:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573558946;
        bh=1mvUFZg10HB3KrdysqlD+leJS3KnmzCcLKXTtJM6gpw=;
        h=X-UI-Sender-Class:From:To:Subject:Date;
        b=H7N5Qr51WtbI+WienWqRcMd1u0bPGSbamxTHFYEj7qIfB/mJrliAxiKqJwFqt8i1H
         XOrBPIv2Ejep6rSG0ZI+1HBzvZVl6HGogqSaMiy/28tjYneJYHgBPr8E4xCqn7DVnK
         vAxVsau3D4tqFePqP+I8kdKvQPILmlln38H2RyE4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [79.139.19.70] ([79.139.19.70]) by web-mail.gmx.net
 (3c-app-mailcom-bs16.server.lan [172.19.170.184]) (via HTTP); Tue, 12 Nov
 2019 12:42:26 +0100
MIME-Version: 1.0
Message-ID: <trinity-6bfe8821-3234-4c44-86f9-d76a3d0cf02b-1573558946461@3c-app-mailcom-bs16>
From:   "John Doe" <inquiz@gmx.com>
To:     linux-kernel@vger.kernel.org
Subject: Linux kernel performance
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 12 Nov 2019 12:42:26 +0100
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:K43cP+z+xi6Ggu1R/+DqydCeOs/SGS/Qt8xqts0woHQcT/+tCMrYC+0iI+mHQGmMBQjr+
 bXEqUTYTPNA0ZWkJ/ebgo7F6CzlXMZjHsJQ9LrCZ8W6vfoIuwkuPz9EqLQ+vX7XBqWVtN53ESg2E
 k1L+F8y+0tbJdZaXlVgFRr9tP1RQHHwN0Ai5eV5GS1oxD7oyyVtm9YJ5alElmLcRPXD8RrUeTv1I
 WJrFxDRA9302E+3fTrOxzRjO1KYxkSCeuBRjjR8pYI6sCrQc78d5T91J3pcyZpm7J9mbLf/xviMI
 V0=
X-UI-Out-Filterresults: notjunk:1;V03:K0:NJaco7nvfq0=:uDo+VSDDrgbPN2I9re8jIi
 ni6y37XFyjTKwYv46fGdtflF7Mog1of1e2NIuZ3t/gc5HSVOt7UZRN8UYO821K3Ixv85cDe6P
 U+aUYGn57eUp3ifd/roD/TUw5OX1Ej/l7N3A6zUVijVZtiJbgOnrBw+JOwIAG3VToOeCI8HHK
 PiJZzWkiGUxdYXPAlko7ZoRWq9374p+DrhKlzz8KysxaZnl/nJT5funnCPBMrC99vt4HLMpw2
 7rz51O70diFq8C3xs83mvopwkjly7cHlKl4VWs/52rrNFVAQi5YzVzCufu0iqvkaRbCbn3Hla
 kGmUYLj/dQgxwptrFl/SBcNhFTMxtKjJsI4PAsI0XLvLRolb/gDI08GETu0xRRwycxbebLU3S
 Z6PF3xs3sT0aiLAW5xRh/2L0Be22VBot5hBzx8c8Z3C3dSgbdfNa0/BYz3Zj4o5kyBJgxbOyq
 nBR05uPIz6wHorFivsZ1CFtlqgVUtB2ZAAQdZajHgJ96RNusqkjp7gjgaacFg/sFEC3ii2Zp4
 iJOzTY3bx0PsQ3OaU9wcf4TCBd96qgUZod5sbBN3HZsVa6u+/+RR56d1+/AcGTbkxASjHGCZD
 kiJ7RMPPTFMo8jSyBlCFWwBqNhOJTs3s/0YzvZ54mrEbq8QTERcR4+f7KlxcYBam5MkrU/tYu
 sWfIIlx2npjj/HxpzQr8saU7MRslhKpuJZU7A7FWZCH288w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dears,

The Disappointing Direction Of Linux Performance From 4.16 To 5.4 Kernels
https://www.phoronix.com/scan.php?page=article&item=linux-416-54&num=1

For example:
The Sockperf socket performance benchmark with its throughput performance has been hit hard, down 32%.
The Hackbench Linux kernel scheduler benchmark has been lower, down 30-40%.
The ctx_clock micro-benchmark shows the impact of context switching performance, down 75%.

inq
