Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6B3C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE1E92082E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554913195;
	bh=gAg7ItIU9xtozLXCrllhDQag8IWHJgtaqRklURafv0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=n7vVtpvhxMZzo4+HOwtlzlGP6WurR2IQq6w7J/Qjkee2Hs7otOeLFfj6NrTgSjidS
	 ClY52qv49D2ENb1nazfw+i6Y5qnyMKBtWwCZCx+QsIEVkamUG0Q/PpVSvdqg9O8yxI
	 DZppu1pn55B2oHU63GuESUOqfTu/hRiQQChB1y+w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387769AbfDJQTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:19:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:54650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727892AbfDJQTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:19:52 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A020D2082E;
        Wed, 10 Apr 2019 16:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554913190;
        bh=gAg7ItIU9xtozLXCrllhDQag8IWHJgtaqRklURafv0Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SMHj9Y4oM+7mBIdPvFqy8aItw30R+O4AVPwqHZGYFZMR4HkDTGdc6x3Q/A+dtx0Og
         ajH22d5Rz27Dz6oVAua0tCAkEoofBBhsA/WwXeJhD6jCTFuFsJrG3gsLfjGYDN+9aw
         qCKs1gLi0/KJ6SaIDbduj/sbublgzhk4W2H93HrE=
Date:   Wed, 10 Apr 2019 12:19:49 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        jgg@ziepe.ca, Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-integrity@vger.kernel.org, linux-kernel@microsoft.com,
        thiruan@microsoft.com, bryankel@microsoft.com
Subject: Re: [PATCH v2 1/3] ftpm: dt-binding: add dts documentation for fTPM
 driver
Message-ID: <20190410161949.GC11568@sasha-vm>
References: <20190409184958.7476-1-sashal@kernel.org>
 <20190409184958.7476-2-sashal@kernel.org>
 <CAL_JsqLXcY9VFuY8xZvek0ybUXetS27jL-PW0XGLSVQR3Nc5aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAL_JsqLXcY9VFuY8xZvek0ybUXetS27jL-PW0XGLSVQR3Nc5aw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 04:18:29PM -0500, Rob Herring wrote:
>On Tue, Apr 9, 2019 at 1:50 PM Sasha Levin <sashal@kernel.org> wrote:
>>
>> The parameters are similar to the ones used by IBM's vTPM and the
>> various I2C tpm drivers.
>
>Bindings describe h/w (or firmware interfaces in this case), not drivers.
>
>>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  .../bindings/security/tpm/tpm_ftpm_tee.txt          | 13 +++++++++++++
>>  .../devicetree/bindings/vendor-prefixes.txt         |  1 +
>>  2 files changed, 14 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/security/tpm/tpm_ftpm_tee.txt
>>
>> diff --git a/Documentation/devicetree/bindings/security/tpm/tpm_ftpm_tee.txt b/Documentation/devicetree/bindings/security/tpm/tpm_ftpm_tee.txt
>> new file mode 100644
>> index 000000000000..20fca67a56c4
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/security/tpm/tpm_ftpm_tee.txt
>> @@ -0,0 +1,13 @@
>> +Required properties:
>> +- compatible: should be "microsoft,ftpm"
>> +- linux,sml-base: 64-bit base address of the reserved memory allocated
>> +                 for the firmware event log
>> +- linux,sml-size: size of the memory allocated for the firmware event log
>
>Firmware is defining linux specific properties? What if I want to run
>BSD? We should use 'reg' here instead.

This is based on already existing code that defines these names, see
tpm_read_log_of() in drivers/char/tpm/eventlog/of.c .

These properties were described similarily by other interfaces (see
Documentation/devicetree/bindings/security/tpm/ibmvtpm.txt or
Documentation/devicetree/bindings/security/tpm/tpm-i2c.txt for example).

We could rename them all if you'd like, I was just trying to follow the
existing code.

>What memory is used here? This should be under /reserved-memory if it
>is part of "main" memory.

That's my understanding, yes.

>Really, I'd prefer to not see this in DT at all. Make the firmware
>discoverable. Why repeat the mistakes of non-discoverable h/w in s/w
>interfaces? OP-Tee at least has defined a mechanism to enumerate TEE
>functions IIRC.

Sadly the firmware already exists as-is on live hardware, there is a
paper describing it back from 2016 and we're stuck having to support
that.

--
Thanks,
Sasha
