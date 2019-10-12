Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2829DECE58D
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 01:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F02C820679
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 01:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="VS+tlDds"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbfJLB15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 21:27:57 -0400
Received: from forward106p.mail.yandex.net ([77.88.28.109]:58893 "EHLO
        forward106p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726903AbfJLB15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 21:27:57 -0400
Received: from mxback3j.mail.yandex.net (mxback3j.mail.yandex.net [IPv6:2a02:6b8:0:1619::10c])
        by forward106p.mail.yandex.net (Yandex) with ESMTP id 025161C80908;
        Sat, 12 Oct 2019 04:27:55 +0300 (MSK)
Received: from sas1-e6a95a338f12.qloud-c.yandex.net (sas1-e6a95a338f12.qloud-c.yandex.net [2a02:6b8:c08:37a4:0:640:e6a9:5a33])
        by mxback3j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id l5LHWxj6Po-Rs2CJcHC;
        Sat, 12 Oct 2019 04:27:54 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1570843674;
        bh=VjH7JDzhlEDfz8hnj0Z4e1eQqaeF/P7jvepG9WoRjJY=;
        h=From:To:Subject:CC:Date:Message-ID;
        b=VS+tlDdsPFV36/i+0WI1iVf3BA/qmkOn/rQ+41yCCp0n1jtLm6yYpLESYH3FjnZkK
         5bwJxz34GYjQq2+r3eLip5qnpTszqXptODKeQRSpOym+1JHcYszNB/3kXoSt2bi++2
         bg+P1/br5LRfHx5GirzzF+9xlrCY4cYKD79N6TGQ=
Authentication-Results: mxback3j.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by sas1-e6a95a338f12.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id GQpQCkZJRX-Rrq4Ihwf;
        Sat, 12 Oct 2019 04:27:53 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Date:   Sat, 12 Oct 2019 09:27:44 +0800
User-Agent: K-9 Mail for Android
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Kernel.org SSL certification expired
To:     mricon@kernel.org
CC:     linux-kernel@vger.kernel.org
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <79BF3B6A-6533-48C7-BD4D-8D64FC2B397A@flygoat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi kernel=2Eorg sysadmin team,

It seems like SSL certification of kernel=2Eorg is expired today=2E With H=
STS enable, we can't reach kernel=2Eorg now=2E


Thanks
--=20
Jiaxun Yang
