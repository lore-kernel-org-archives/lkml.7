Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07379C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C88D82085A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553506286;
	bh=wLyZ8ZhlRqUs4zntW7EdVCgDPoIy+jM+ep1Zk/cTSPg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OxV/bzVa+2k7sra8QgTjPhd1iSFRk9Fk5b5PQ7+1QY0Cc7MBEul8giQ1UXKM6cQ1b
	 zw7u+6+1aa135kNQtBKAxS1fGBA+bnd30kvuvjDyN1+zWC3xQSXWtQRYUdq5Le0pi1
	 yeJuAhL0FYkywtSPEAKshuiBtGTE1RLv5CyZ0y70=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730360AbfCYJbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 05:31:25 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46065 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730147AbfCYJbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 05:31:25 -0400
Received: by mail-ot1-f65.google.com with SMTP id e5so7352854otk.12;
        Mon, 25 Mar 2019 02:31:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EokbbCNypUQRj97LEIrYreQHlxeyCDH0r7kVx5EfcRI=;
        b=Kh1B9f+botDvSwpE885yEtUb4tKL9/ItJXbwJaDtzangB43mlX5KQ41+y2r78q+uTM
         l9+ChcoG4dy3vx7ec3Gk2hORK64tQ0uNjqLQh4zuPS3wRJGcYbLIlS0v6XZxefVmv3fq
         0oQ3+3fTthJFfUvoPbm6QoEcUnYyLY+v56C/o5J1l2keqHdMFnPqmfKPD5crWBdyTdje
         ZyNGGlYddyeJdyE+J1Nid14w/U+yEE2BbltpX3Y5q9eCYX+egbtAAsh4yTJZn83voynh
         aG9IloLtJwXZr5ZBd0NAXIP9Lx5U45euUVSly186iw3ClJnm4RHoGjiiOFVGilmvp7uN
         SVKg==
X-Gm-Message-State: APjAAAXYZFulRJ7p/ij8D/sV5B3pRs1EyF90vBkXIcfGhFOdC9niQa6g
        5Ad7HFJviiUhQGsdjO2LE3QvBcXu/AQC/JfkgqNNfg==
X-Google-Smtp-Source: APXvYqwu7YweWa8X1gplgQBHJgdlXgIF71t5974E2SUR+6vL9ZuUUqtef5jASbXV2aSs4CDoz81ngsDYXpmSnDXKWDo=
X-Received: by 2002:a9d:738c:: with SMTP id j12mr16252144otk.119.1553506284446;
 Mon, 25 Mar 2019 02:31:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190322134705.27994-1-thomas.preston@codethink.co.uk>
In-Reply-To: <20190322134705.27994-1-thomas.preston@codethink.co.uk>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 25 Mar 2019 10:31:13 +0100
Message-ID: <CAJZ5v0isa7x+XPAregcKtMxtgsNw43JuBhGB_1x3eHkvaV8HRg@mail.gmail.com>
Subject: Re: [PATCH] Documentation: acpi: Add an example for PRP0001
To:     Thomas Preston <thomas.preston@codethink.co.uk>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 2:47 PM Thomas Preston
<thomas.preston@codethink.co.uk> wrote:
>
> Add an example for the magic PRP0001 device ID which allows matching
> ACPI devices against drivers using OF Device Tree compatible property.
> It wasn't clear to me that PRP0001 could be used in _CID.

Mika, Andy, can you have a look at this, please?

> Signed-off-by: Thomas Preston <thomas.preston@codethink.co.uk>
> ---
>  Documentation/acpi/enumeration.txt | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/Documentation/acpi/enumeration.txt b/Documentation/acpi/enumeration.txt
> index 7bcf9c3d9fbe..391db643065a 100644
> --- a/Documentation/acpi/enumeration.txt
> +++ b/Documentation/acpi/enumeration.txt
> @@ -410,6 +410,33 @@ Specifically, the device IDs returned by _HID and preceding PRP0001 in the _CID
>  return package will be checked first.  Also in that case the bus type the device
>  will be enumerated to depends on the device ID returned by _HID.
>
> +For example, the following ACPI sample might be used to enumerate an lm75-type
> +I2C temperature sensor and match it to the driver using the Device Tree
> +namespace link:
> +
> +       Device (TMP0)
> +       {
> +               Name (_HID, "TITMP75") /* _HID will appear in sysfs */
> +               Name (_CID, "PRP0001")
> +               Name (_DSD, Package() {
> +                       ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> +                       Package () {
> +                               Package (2) { "compatible", "ti,tmp75" },
> +                       }
> +               })
> +               Method (_CRS, 0, Serialized)
> +               {
> +                       Name (SBUF, ResourceTemplate ()
> +                       {
> +                               I2cSerialBusV2 (0x48, ControllerInitiated,
> +                                       400000, AddressingMode7Bit,
> +                                       "\\_SB.PCI0.I2C1", 0x00,
> +                                       ResourceConsumer, , Exclusive,)
> +                       })
> +                       Return (SBUF)
> +               }
> +       }
> +
>  It is valid to define device objects with a _HID returning PRP0001 and without
>  the "compatible" property in the _DSD or a _CID as long as one of their
>  ancestors provides a _DSD with a valid "compatible" property.  Such device
> --
> 2.11.0
>
