Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8855EC432C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 05:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FD9420715
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 05:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="ss8XNjE0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfLBF4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 00:56:01 -0500
Received: from forward101o.mail.yandex.net ([37.140.190.181]:60330 "EHLO
        forward101o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725807AbfLBF4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 00:56:00 -0500
X-Greylist: delayed 457 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Dec 2019 00:55:59 EST
Received: from mxback6g.mail.yandex.net (mxback6g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:167])
        by forward101o.mail.yandex.net (Yandex) with ESMTP id 65B1C3C01542
        for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2019 08:48:20 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback6g.mail.yandex.net (mxback/Yandex) with ESMTP id IQ5QdJVuvV-mJpGjn6w;
        Mon, 02 Dec 2019 08:48:19 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1575265699;
        bh=us1Vgl2QP5y+xIT14PqHmlP89+YLWUAfmbs9aThDLW8=;
        h=Message-Id:Date:Subject:To:From;
        b=ss8XNjE0WBNkzRYQBh5iBelDp3yWhKoJl7hMZPz3Y+ehC207Ze4gTsHzzHM/Apg0d
         ItLe7M3Add4nndixH8CQX+Sq3qm7SqBKvHubc3BGFDbQsTgx3upFotOmxqrdi1O7TC
         HMuN4ZwpUwdB12JOa+pI57qnzsD54tU1UxTToJu0=
Authentication-Results: mxback6g.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by sas1-2bf44b70450e.qloud-c.yandex.net with HTTP;
        Mon, 02 Dec 2019 08:48:19 +0300
From:   Andrey Ponomarenko <andrewponomarenko@yandex.ru>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Linux Hardware Trends
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Mon, 02 Dec 2019 08:48:19 +0300
Message-Id: <3476391575265699@sas1-2bf44b70450e.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

Today I'm glad to announce a new statistical analysis project called "Trends in Hardware" based on the data collected by Linux community during last 5 years on the Linux Hardware portal: https://linux-hardware.org/?view=trends

With the help of the report one can identify most popular hardware characteristics and track their change over time.

The report consists of 8 sections currently: OS properties (kernel, arch, DE, boot mode, etc.), Motherboard (model, kind, mfg year, etc.), Hard drives (model, kind, size, failures, etc.), CPU (model, microarch, etc.), Video cards (model, combinations, etc.), Monitors (model, resolution, aspect ratio, density, etc.), Network (controller, kind, usage, etc.) and Compatibility (device driver support).

In each section one can find a pie chart of most popular values and can click on any element to see detailed list of computers and hardware probes. Be careful when interpreting timeline charts, since they interfere with the overall growth of the project popularity (make attention to change in ratio, rather than growth). The project can be considered also as a powerful search engine to find Linux powered computers with interested characteristics.

Most active participants in the study currently are Ubuntu, Rosa, Mint, Endless, Fedora, Arch, Manjaro, Debian, Zorin, openSUSE, KDE neon, Clear Linux and Gentoo. For top distributions in this list one can find most accurate results. Other distributions are also involved in the survey, but with small (inaccurate) data sets yet. However, the total contribution of "small" Linux distributions in "All Linux" survey is significant.

The static version of the report is shared on the Github: https://github.com/linuxhw/Trends

Please suggest new hardware/OS characteristics to track in the project if you are interested and please participate in the study by following instructions on https://github.com/linuxhw/hw-probe.

Thanks!
