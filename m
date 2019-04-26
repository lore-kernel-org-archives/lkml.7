Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45DAC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DD73208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfDZQsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 12:48:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:53880 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726279AbfDZQsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 12:48:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E1A19ACB1;
        Fri, 26 Apr 2019 16:48:06 +0000 (UTC)
Message-ID: <1556297285.22365.4.camel@suse.de>
Subject: Re: [RFC PATCH RESEND] i2c-piix4: Add Hygon Dhyana SMBus support
From:   Jean Delvare <jdelvare@suse.de>
To:     Pu Wen <puwen@hygon.cn>
Cc:     bp@alien8.de, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>
Date:   Fri, 26 Apr 2019 18:48:05 +0200
In-Reply-To: <0c895129-23af-2fc6-0c99-61348a69f961@hygon.cn>
References: <1555938607-2865-1-git-send-email-puwen@hygon.cn>
         <20190426113751.77befab1@endymion>
         <0c895129-23af-2fc6-0c99-61348a69f961@hygon.cn>
Organization: Suse Linux
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-04-26 at 22:23 +0800, Pu Wen wrote:
> On 2019/4/26 17:38, Jean Delvare wrote:
> > I would like you to also document the new supported chipset in
> > drivers/i2c/busses/Kconfig and Documentation/i2c/busses/i2c-piix4 as
> > well as in the header comment of i2c-piix4.c itself. I know it seems
> > redundant but it helps the user know which driver they need.
> 
> Because Hygon uses the same PCI device ID of AMD's, so is it appropriate 
> to document with the name "Hygon CZ" or just "Hygon"?

"Hygon CZ" please, as Hygon is the vendor not the device, and I can
imagine you may create more devices in the future.

Thanks,
-- 
Jean Delvare
SUSE L3 Support
