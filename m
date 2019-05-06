Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36489C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D43C2053B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfEFPQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 11:16:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:52786 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726236AbfEFPQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 11:16:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5A4E8ACFB;
        Mon,  6 May 2019 15:16:54 +0000 (UTC)
Date:   Mon, 6 May 2019 17:16:52 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2] eeprom: ee1004: Deal with nack on page selection
Message-ID: <20190506171652.3ba909de@endymion>
In-Reply-To: <04843f27-bb0f-d631-32c8-80cd122b7399@linux.intel.com>
References: <20190506151539.69ee75e8@endymion>
        <20190506151656.47494e56@endymion>
        <04843f27-bb0f-d631-32c8-80cd122b7399@linux.intel.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 May 2019 17:03:20 +0300, Jarkko Nikula wrote:
> On 5/6/19 4:16 PM, Jean Delvare wrote:
> > Some EE1004 implementations will not properly ack page selection
> > commands. They still set the page correctly, so there is no actual
> > error. Deal with this case gracefully by checking the currently
> > selected page after we receive a nack. If the page is set right then
> > we can continue.
> > 
> > Signed-off-by: Jean Delvare <jdelvare@suse.de>
> > Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >   drivers/misc/eeprom/ee1004.c |   12 +++++++++++-
> >   1 file changed, 11 insertions(+), 1 deletion(-)
>
> Does Dreamcat4 deserve reported and tested by tags here? I guess 
> anonymous address is fine with those tags?

My assumption is that someone who posts anonymously in the first place
has no desire to be credited for anything or even mentioned anywhere.

> (I re-tested these two patches on top of v5.1 and they make decode-dimms 
> working on a machine with 2-4 * Crucial DD4 dimms)

Thank you very much.

-- 
Jean Delvare
SUSE L3 Support
