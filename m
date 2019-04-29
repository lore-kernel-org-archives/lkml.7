Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC74C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6E3C2084B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbfD2O0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 10:26:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:50454 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728284AbfD2O0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 10:26:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0BF1BAD49;
        Mon, 29 Apr 2019 14:26:19 +0000 (UTC)
Date:   Mon, 29 Apr 2019 16:26:17 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Pu Wen <puwen@hygon.cn>
Cc:     <bp@alien8.de>, <linux-i2c@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2] i2c-piix4: Add Hygon Dhyana SMBus support
Message-ID: <20190429162617.3b936981@endymion>
In-Reply-To: <1556327264-31730-1-git-send-email-puwen@hygon.cn>
References: <1556327264-31730-1-git-send-email-puwen@hygon.cn>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Apr 2019 09:07:44 +0800, Pu Wen wrote:
> The Hygon Dhyana CPU has the SMBus device with PCI device ID 0x790b,
> which is the same as AMD CZ SMBus device. So add Hygon Dhyana support
> to the i2c-piix4 driver by using the code path of AMD.
> 
> Signed-off-by: Pu Wen <puwen@hygon.cn>
> ---
> v1->v2:
>   - Remove the revision number checking for Hygon SMBus device.
>   - Document the new supported chipset in drivers/i2c/busses/Kconfig
>     and Documentation/i2c/busses/i2c-piix4 as well as in the header
> 	comment of i2c-piix4.c.
> 
>  Documentation/i2c/busses/i2c-piix4 |  2 ++
>  drivers/i2c/busses/Kconfig         |  1 +
>  drivers/i2c/busses/i2c-piix4.c     | 15 +++++++++++----
>  3 files changed, 14 insertions(+), 4 deletions(-)
> (...)

Looks good to me now, thanks.

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support
