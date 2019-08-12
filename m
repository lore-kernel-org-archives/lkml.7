Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB326C41514
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 21:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E8F82085A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 21:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565645689;
	bh=S4cnd35CkG0wBAzyUMh2O31IjCJTpSxUWG+UBGSodlY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=WtMAmSRe50EDu1YXGGJlgW82gEgOhN+j/w/mEP/hGr0hessMQ1JZqlhNcVrpjMm5d
	 tmwljzMX8k8zHQRAbN3sjaGgejpqi5iPI2brAWm/OXRUHhetEQEBBpykC5gIG1S4l2
	 8OnU+lGHRAo2o/W7mrjgquDod1hypZt/dEeU39Pw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfHLVes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 17:34:48 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41018 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbfHLVer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 17:34:47 -0400
Received: by mail-ot1-f65.google.com with SMTP id o101so11723010ota.8;
        Mon, 12 Aug 2019 14:34:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jZTSZJjRei2HkvD9YfG1B9/O0uyYnQM5GtMkOOuKYJE=;
        b=bQ1CgLNoOLaieTjRRaUndcFop4DrBa3U+zwMj+GICSMI64uYIppihqinSmCGWcUNAm
         iauRisVdBne/VpkoixcQ2fVzZu8+Pa3ta2Cx9zSKCzl4t3XeQ7wFsS6G/H9Pc68C4TuQ
         gKPfAZQUpuPvekLo6l4vudnjzKhsUwsCu9RlHTxedMfRjX72+jnrHfJAmCdtoccmHrEi
         PpATJAA5MSS8fjnwvpM0U0zUFlzAvOgh5KQ/r/tx4ac324+ZYA2yfyhvC5aCGrYBj+UI
         W9pmfqscP0xZztd3FkYcmIM/DR+bfw2EUZaJdNmeOn3D6cLF52slywOXpDjKSwr9dpGw
         PMog==
X-Gm-Message-State: APjAAAWfZXCXJzFcubpFyarHm9tValrDSrPnCicXHPqDp84I1HkQ60FN
        0+7toRUZGWSgH877tikbG5dyfl6q865IvNMtHnw=
X-Google-Smtp-Source: APXvYqzt40UUbia0mqNs3QKrFhMjfhsG2yXjJOoVC88IG8RVQJZB7huJTl0fjcO+PdhTNJJOT5G6LKh/jvuyBUTfhg0=
X-Received: by 2002:a05:6830:154:: with SMTP id j20mr14892283otp.266.1565645686269;
 Mon, 12 Aug 2019 14:34:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190812123847.50802-1-mika.westerberg@linux.intel.com> <20190812123847.50802-9-mika.westerberg@linux.intel.com>
In-Reply-To: <20190812123847.50802-9-mika.westerberg@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 12 Aug 2019 23:34:35 +0200
Message-ID: <CAJZ5v0haDniwqEwG1suE80sk4bAwpwCQweVMGZoeNB7h04gFOQ@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] ACPI / property: Add two new Thunderbolt property
 GUIDs to the list
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Anthony Wong <anthony.wong@canonical.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Raanan Avargil <raanan.avargil@intel.com>,
        David Laight <David.Laight@aculab.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 2:39 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Ice Lake Thunderbolt controller includes two new device property
> compatible properties that we need to be able to extract in the driver
> so add them to the growing array of GUIDs.
>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/property.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index ea3d700da3ca..e095334eaec9 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -39,6 +39,12 @@ static const guid_t prp_guids[] = {
>         /* External facing port GUID: efcc06cc-73ac-4bc3-bff0-76143807c389 */
>         GUID_INIT(0xefcc06cc, 0x73ac, 0x4bc3,
>                   0xbf, 0xf0, 0x76, 0x14, 0x38, 0x07, 0xc3, 0x89),
> +       /* Thunderbolt GUID for IMR_VALID: c44d002f-69f9-4e7d-a904-a7baabdf43f7 */
> +       GUID_INIT(0xc44d002f, 0x69f9, 0x4e7d,
> +                 0xa9, 0x04, 0xa7, 0xba, 0xab, 0xdf, 0x43, 0xf7),
> +       /* Thunderbolt GUID for WAKE_SUPPORTED: 6c501103-c189-4296-ba72-9bf5a26ebe5d */
> +       GUID_INIT(0x6c501103, 0xc189, 0x4296,
> +                 0xba, 0x72, 0x9b, 0xf5, 0xa2, 0x6e, 0xbe, 0x5d),
>  };
>
>  /* ACPI _DSD data subnodes GUID: dbb8e3e6-5886-4ba6-8795-1319f52a966b */
> --
> 2.20.1
>
