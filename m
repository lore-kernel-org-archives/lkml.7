Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE824C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 17:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B392C2084B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 17:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554918844;
	bh=OKNCXq/u5TsjghIDiv1qzNoZhWbxKDfTSSvKapP630o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1kn1yYqxyxpbVTWEsp9HdpBwiKLn1/+xrfwZoaxjN+w68K2PoglEkhrgS6KXeQTu8
	 cI7vSAL9m0NjlIUo1ZbnfjuQdjsHSyvrTeh2U9NLc7GvJXsLq3Sq55a16x846diCpw
	 d6mbR1AtCvQLjNBxCI2mMsZQsenzHoKtb2N99z8A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730626AbfDJRyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 13:54:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:52792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730566AbfDJRyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 13:54:01 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97D802063F;
        Wed, 10 Apr 2019 17:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554918840;
        bh=OKNCXq/u5TsjghIDiv1qzNoZhWbxKDfTSSvKapP630o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CLQUMqoDtyBeAaYWnqqViRedTVyp7e+vssIRSwlF9NAV9zVJ18eIeUR5lC0sd7DwI
         /RXw+vIqrHngUynUaXlfAOiOah3uILk4TPYx0i0j0dYGVXXZ4u31G0JKooSz+9jvvH
         f6pNEbJ0t2iqieGDdaey10HDjBkL+Cma9Lv1PjkY=
Date:   Wed, 10 Apr 2019 13:53:59 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Rob Herring <robh+dt@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-integrity@vger.kernel.org, linux-kernel@microsoft.com,
        thiruan@microsoft.com, bryankel@microsoft.com
Subject: Re: [PATCH v2 1/3] ftpm: dt-binding: add dts documentation for fTPM
 driver
Message-ID: <20190410175359.GE11568@sasha-vm>
References: <20190409184958.7476-1-sashal@kernel.org>
 <20190409184958.7476-2-sashal@kernel.org>
 <CAL_JsqLXcY9VFuY8xZvek0ybUXetS27jL-PW0XGLSVQR3Nc5aw@mail.gmail.com>
 <20190410161949.GC11568@sasha-vm>
 <CAL_JsqJ0p8MsFe2HnqVHvdGyz=6P7dV++xj1d1TTgcobsFqpjg@mail.gmail.com>
 <20190410170316.GK8997@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190410170316.GK8997@ziepe.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 02:03:16PM -0300, Jason Gunthorpe wrote:
>On Wed, Apr 10, 2019 at 12:01:37PM -0500, Rob Herring wrote:
>> On Wed, Apr 10, 2019 at 11:19 AM Sasha Levin <sashal@kernel.org> wrote:
>> >
>> > On Tue, Apr 09, 2019 at 04:18:29PM -0500, Rob Herring wrote:
>> > >On Tue, Apr 9, 2019 at 1:50 PM Sasha Levin <sashal@kernel.org> wrote:
>> > >>
>> > >> The parameters are similar to the ones used by IBM's vTPM and the
>> > >> various I2C tpm drivers.
>> > >
>> > >Bindings describe h/w (or firmware interfaces in this case), not drivers.
>> > >
>> > >>
>> > >> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> > >>  .../bindings/security/tpm/tpm_ftpm_tee.txt          | 13 +++++++++++++
>> > >>  .../devicetree/bindings/vendor-prefixes.txt         |  1 +
>> > >>  2 files changed, 14 insertions(+)
>> > >>  create mode 100644 Documentation/devicetree/bindings/security/tpm/tpm_ftpm_tee.txt
>> > >>
>> > >> diff --git a/Documentation/devicetree/bindings/security/tpm/tpm_ftpm_tee.txt b/Documentation/devicetree/bindings/security/tpm/tpm_ftpm_tee.txt
>> > >> new file mode 100644
>> > >> index 000000000000..20fca67a56c4
>> > >> +++ b/Documentation/devicetree/bindings/security/tpm/tpm_ftpm_tee.txt
>> > >> @@ -0,0 +1,13 @@
>> > >> +Required properties:
>> > >> +- compatible: should be "microsoft,ftpm"
>> > >> +- linux,sml-base: 64-bit base address of the reserved memory allocated
>> > >> +                 for the firmware event log
>> > >> +- linux,sml-size: size of the memory allocated for the firmware event log
>> > >
>> > >Firmware is defining linux specific properties? What if I want to run
>> > >BSD? We should use 'reg' here instead.
>> >
>> > This is based on already existing code that defines these names, see
>> > tpm_read_log_of() in drivers/char/tpm/eventlog/of.c .
>>
>> BTW, that probably needs updating to handle endianness correctly.
>
>IIRC this legacy IBM code has broken endianness in the firmware..
>
>All that stuff in read_log_of, and the related DT stuff, is historical
>IBM special case-ness and should not be copied into new things.

The fTPM driver does not use it on it's own, so I guess I can just drop
this patch then?

--
Thanks,
Sasha
