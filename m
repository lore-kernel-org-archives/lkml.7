Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019A1C47E49
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 12:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD971214D8
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 12:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730421AbfKFMFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 07:05:03 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:49963 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728550AbfKFMFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 07:05:03 -0500
Received: by mail-io1-f69.google.com with SMTP id x1so17889588ior.16
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 04:05:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:content-transfer-encoding;
        bh=aKg1YSdsDPM3kPA3fqKhhycFO79pL2xKpjm55teHNCY=;
        b=ZRictcdos10xZobqo4EewSui6KnvxyFCmlmJRgRR4U0NnJi5QA8CC4vdfBisilJ4ro
         hXl+TRsUy1uNli5WfgOk3v7GxlvLxFeYufVNbMYynbboqJSwqW44xa30rjB2/+E5Fefq
         JA9uoVf+ppPDzdXYo1O1AqpQ0C8q9xcx5ck/K/ivT/snyH7BjtkAseEFsh5ZCVV8Vzja
         VEYCBPSyhXAEMKfDvvXSFyZw9mh2K0N7BfsxTZGmbzC0PLsE3sm64EKwCvGOfInSC2ew
         6EXqro3P59KfNR0l9/3waCI81czBNRHo4sqN3TWDFfe2x9aKnKlMaCGJzeb7LdBW2W/y
         plug==
X-Gm-Message-State: APjAAAV3mzaHXR9BVmYGwIohcfhRzrQGjGZIsY7HAW8hwGPH7uC7aXXK
        MJsduez26KxSJDsMRhcN20feqGZLDjTevM6FVGz+YhfJQjyD
X-Google-Smtp-Source: APXvYqxbEDmuTSe9QWi+sDEkhFWu6TGHEN2DzY5XjJ94jH89o5JRK0ApeKbFTZF7NhYFevjVQa7JVfPLI6AvXEUrFUaAbBj8u9hQ
MIME-Version: 1.0
X-Received: by 2002:a92:1613:: with SMTP id r19mr1645229ill.10.1573041900998;
 Wed, 06 Nov 2019 04:05:00 -0800 (PST)
Date:   Wed, 06 Nov 2019 04:05:00 -0800
In-Reply-To: <0000000000004dfaf005969d1755@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b9dd9c0596ac5b94@google.com>
Subject: Re: INFO: task hung in snd_timer_close
From:   syzbot <syzbot+f1048ebddb93befb085f@syzkaller.appspotmail.com>
To:     alexandre.belloni@bootlin.com, alsa-devel-owner@alsa-project.org,
        alsa-devel@alsa-project.org, bhelgaas@google.com,
        broonie@kernel.org, kirr@nexedi.com, linux-kernel@vger.kernel.org,
        linux@roeck-us.net, lkundrak@v3.sk, maxime.ripard@bootlin.com,
        perex@perex.cz, peron.clem@gmail.com, robh@kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        tiwai@suse.com, tiwai@suse.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

c3l6Ym90IGhhcyBiaXNlY3RlZCB0aGlzIGJ1ZyB0bzoNCg0KY29tbWl0IGIyMDQ1MzAzMTQ3MjU0
ZDAxYjFkYjkwYTgzZTVkZjM4MzJjNDI2NGINCkF1dGhvcjogQ2zDqW1lbnQgUMOpcm9uIDxwZXJv
bi5jbGVtQGdtYWlsLmNvbT4NCkRhdGU6ICAgTW9uIE1heSAyNyAyMDowNjoyMSAyMDE5ICswMDAw
DQoNCiAgICAgZHQtYmluZGluZ3M6IHNvdW5kOiBzdW40aS1zcGRpZjogQWRkIEFsbHdpbm5lciBI
NiBjb21wYXRpYmxlDQoNCmJpc2VjdGlvbiBsb2c6ICBodHRwczovL3N5emthbGxlci5hcHBzcG90
LmNvbS94L2Jpc2VjdC50eHQ/eD0xNGFjZWNiNGUwMDAwMA0Kc3RhcnQgY29tbWl0OiAgIGE5OWQ4
MDgwIExpbnV4IDUuNC1yYzYNCmdpdCB0cmVlOiAgICAgICB1cHN0cmVhbQ0KZmluYWwgY3Jhc2g6
ICAgIGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL3gvcmVwb3J0LnR4dD94PTE2YWNlY2I0
ZTAwMDAwDQpjb25zb2xlIG91dHB1dDogaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20veC9s
b2cudHh0P3g9MTJhY2VjYjRlMDAwMDANCmtlcm5lbCBjb25maWc6ICBodHRwczovL3N5emthbGxl
ci5hcHBzcG90LmNvbS94Ly5jb25maWc/eD04YzVlMmVjYTNmMzFmOWJmDQpkYXNoYm9hcmQgbGlu
azogaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20vYnVnP2V4dGlkPWYxMDQ4ZWJkZGI5M2Jl
ZmIwODVmDQpzeXogcmVwcm86ICAgICAgaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20veC9y
ZXByby5zeXo/eD0xMjZiYzY1OGUwMDAwMA0KDQpSZXBvcnRlZC1ieTogc3l6Ym90K2YxMDQ4ZWJk
ZGI5M2JlZmIwODVmQHN5emthbGxlci5hcHBzcG90bWFpbC5jb20NCkZpeGVzOiBiMjA0NTMwMzE0
NzIgKCJkdC1iaW5kaW5nczogc291bmQ6IHN1bjRpLXNwZGlmOiBBZGQgQWxsd2lubmVyIEg2ICAN
CmNvbXBhdGlibGUiKQ0KDQpGb3IgaW5mb3JtYXRpb24gYWJvdXQgYmlzZWN0aW9uIHByb2Nlc3Mg
c2VlOiBodHRwczovL2dvby5nbC90cHNtRUojYmlzZWN0aW9uDQo=
