Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B524DC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 14:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95379206E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 14:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbfFGOQp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 10:16:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:35012 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728523AbfFGOQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 10:16:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0F31FAECD;
        Fri,  7 Jun 2019 14:16:44 +0000 (UTC)
Date:   Fri, 7 Jun 2019 16:16:40 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Pali =?UTF-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        =?UTF-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>,
        Steven Honeyman <stevenhoneyman@gmail.com>,
        Valdis.Kletnieks@vt.edu,
        Jochen Eisinger <jochen@penguin-breeder.org>,
        Gabriele Mazzotta <gabriele.mzt@gmail.com>,
        Andy Lutomirski <luto@kernel.org>, Mario_Limonciello@dell.com,
        Alex Hung <alex.hung@canonical.com>,
        Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v5] i2c: i801: Register optional lis3lv02d I2C device on
 Dell machines
Message-ID: <20190607161640.0d90e1b9@endymion>
In-Reply-To: <20190606181845.14091-1-pali.rohar@gmail.com>
References: <20190606181845.14091-1-pali.rohar@gmail.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  6 Jun 2019 20:18:45 +0200, Pali Rohár wrote:
> Dell platform team told us that some (DMI whitelisted) Dell Latitude
> machines have ST microelectronics accelerometer at I2C address 0x29.
> 
> Presence of that ST microelectronics accelerometer is verified by existence
> of SMO88xx ACPI device which represent that accelerometer. Unfortunately
> ACPI device does not specify I2C address.
> 
> This patch registers lis3lv02d device for selected Dell Latitude machines
> at I2C address 0x29 after detection. And for Dell Vostro V131 machine at
> I2C address 0x1d which was manually detected.
> 
> Finally commit a7ae81952cda ("i2c: i801: Allow ACPI SystemIO OpRegion to
> conflict with PCI BAR") allowed to use i2c-i801 driver on Dell machines so
> lis3lv02d correctly initialize accelerometer.
> 
> Tested on Dell Latitude E6440.
> 
> Signed-off-by: Pali Rohár <pali.rohar@gmail.com>
> 
> ---
> Changes since v4:
>  * Remove usage of redundant acpi_bus_get_status_handle()
>  * Update comment about acpi_get_devices()
> (...)

Looks all good now.

Reviewed-by: Jean Delvare <jdelvare@suse.de>

Thanks!
-- 
Jean Delvare
SUSE L3 Support
