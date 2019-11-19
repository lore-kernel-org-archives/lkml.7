Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E895C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EE2320692
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbfKSO2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 09:28:55 -0500
Received: from ms.lwn.net ([45.79.88.28]:38514 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726378AbfKSO2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 09:28:54 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id EB26C2B2;
        Tue, 19 Nov 2019 14:28:53 +0000 (UTC)
Date:   Tue, 19 Nov 2019 07:28:52 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Giovanni Mascellani <gio@debian.org>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Pali =?UTF-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] dell-smm-hwmon: Add documentation
Message-ID: <20191119072852.683885f6@lwn.net>
In-Reply-To: <20191119134921.168424-2-gio@debian.org>
References: <20191119134921.168424-1-gio@debian.org>
        <20191119134921.168424-2-gio@debian.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Nov 2019 14:49:21 +0100
Giovanni Mascellani <gio@debian.org> wrote:

> Part of the documentation is taken from the README of the userspace
> utils (https://github.com/vitorafsr/i8kutils). The license is GPL-2+
> and the author Massimo Dal Zotto is already credited as author of
> the module. Therefore there should be no copyright problem.

Given that you know the details, could you maybe put an SPDX tag at the
top with the licensing information?

Otherwise looks good.

Thanks,

jon
