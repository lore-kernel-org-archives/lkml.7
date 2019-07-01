Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E32BC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 08:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5182B208C4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 08:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbfGAI4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 04:56:03 -0400
Received: from mail.steuer-voss.de ([85.183.69.95]:50126 "EHLO
        mail.steuer-voss.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbfGAI4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 04:56:02 -0400
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: by mail.steuer-voss.de (Postfix, from userid 1000)
        id EB700440A7; Mon,  1 Jul 2019 10:55:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mail.steuer-voss.de (Postfix) with ESMTP id E3B7F42021;
        Mon,  1 Jul 2019 10:55:59 +0200 (CEST)
Date:   Mon, 1 Jul 2019 10:55:59 +0200 (CEST)
From:   Nikolaus Voss <nv@vosn.de>
X-X-Sender: nv@fox.voss.local
To:     Mark Brown <broonie@kernel.org>
cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Andreas Dannenberg <dannenberg@ti.com>,
        "Andrew F. Davis" <afd@ti.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH] sound/soc/codecs/tas5720.c: add ACPI support
In-Reply-To: <20190628143037.GH5379@sirena.org.uk>
Message-ID: <alpine.DEB.2.20.1907011055090.2390@fox.voss.local>
References: <20190628123416.16298-1-nikolaus.voss@loewensteinmedical.de> <20190628143037.GH5379@sirena.org.uk>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jun 2019, Mark Brown wrote:
> On Fri, Jun 28, 2019 at 02:34:16PM +0200, Nikolaus Voss wrote:
>> Add support for ACPI enumeration for tas5720 and tas5722.
>> Use device_match API to unify access to driver data for DT and ACPI.
>> Aggregate variant stuff into its own struct and directly reference
>> it in variant data for i2c/of/acpi_device_id.
>
> Please use subject lines matching the style for the subsystem.  This
> makes it easier for people to identify relevant patches.
>
> There's a huge amount of refactoring in here as well as the enumeration
> changes, please split this up into a patch series as covered in
> submitting-patches.rst for review.
>

Ok, thanks for the feedback, I'll prepare a series.

Nikolaus

