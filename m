Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F038C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 09:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E3A82070B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 09:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbfHTJWS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 05:22:18 -0400
Received: from enpas.org ([46.38.239.100]:39178 "EHLO mail.enpas.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729194AbfHTJWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 05:22:16 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.enpas.org (Postfix) with ESMTPSA id 99F0910006F;
        Tue, 20 Aug 2019 09:22:13 +0000 (UTC)
Date:   Tue, 20 Aug 2019 11:22:12 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <CAMuHMdV1r5LphqNHyM9z8QXbqhAb6skH4wpPq=ZH6XRBHnxwuw@mail.gmail.com>
References: <20190819121618.16557-1-max@enpas.org> <20190819121618.16557-3-max@enpas.org> <CAMuHMdV1r5LphqNHyM9z8QXbqhAb6skH4wpPq=ZH6XRBHnxwuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v5 3/3] i2c/busses/i2c-icy: Add LTC2990 present on 2019 board revision
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Linux I2C <linux-i2c@vger.kernel.org>, linux-hwmon@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
From:   Max <max@enpas.org>
Message-ID: <55E57575-B53F-495F-BDBC-E69E69752CDA@enpas.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On August 20, 2019 11:18:36 AM GMT+02:00, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>Since commit d3e1b617ae20c459 ("i2c: allow specify device properties in
>i2c_board_info"), the properties could be provided by info->properties,
>too.
>However, according to the comments for device_add_properties(), this is
>valid only if there is a real firmware node present.
>
>If that is true, Max' use is correct, while e.g. commit
>6a7836ba7fb4abf6
>("ARM: imx: pca100: use device properties for at24 eeprom") isn't?

Yup, I saw that too. Any hints would be greatly appreciated!

Max
