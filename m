Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DA5C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1723206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555599163;
	bh=y4sLHKDakcuZKljbhMuK/uX0APJNMPqGZlRpPDfynJs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FhvzagscTWCjGaZK7RjDu1s5vphjJk4t/rHh5fMbRz+gqCx903CaqVB2g82EMnz8u
	 wdl8TqZgHhsp9hUvO/bslk6FX1mHxIGJvCIs25UgV0l5wrgGqvXl234i8ZnVTqoY37
	 eNF7uGGX6ZTleKa9+hyIP+78FyX/K1rOtHjVkImE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389405AbfDROwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 10:52:42 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44407 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733192AbfDROwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 10:52:41 -0400
Received: by mail-ot1-f65.google.com with SMTP id d24so1910394otl.11;
        Thu, 18 Apr 2019 07:52:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WEIuCuhL9yTN6ExnNV/nTja/EVSP7iGG7vhZCBM1j98=;
        b=o/LTO0oxSXpkPOHI23PD2cLU9BBObihrToo9vkS0hfytRVH1L1DqWP3vLn24WK+XmD
         uhMbV/IZkxjJJZbMdJmf1C3QsO3bLuPCuG0B4t0XNgUYb+r+k+B75f5tsH+UittZXWE/
         pKkdtYw1UcDcmczqna+fSj48ks/niYWKUAHpZoIl24xkEyu+D+NCbwmuMM7atIJ1CXbT
         KtTDWTloE/4H9jAsSqGjba9M/vMvyv8GW9A5Oao/GF6a06bE2VVI6HFB5sfUWuOboJkR
         v612pfSpyZsZD39fs+pZAX1v3yu12GPkcolZfkfhZu0V2FMlaHD5/2zt6rk1bbzU53/u
         /7Fw==
X-Gm-Message-State: APjAAAU1+YJpTCCjgQcUqCSKZnbeWSCGrtjF/I5lVwRfRrEMu1gnFcyV
        39FxlVqkCDQ8UZDzcaAaBFO26ddOIOILM25b4gk=
X-Google-Smtp-Source: APXvYqyYW4y9RbsVm4oduMOyQT1xFIQ4BTfczhP+o90RGIAMAkAcCKwuZO3yW2cic5fr+0BMBf3KA22FD3/zqZOuGl4=
X-Received: by 2002:a9d:7a50:: with SMTP id z16mr3770782otm.363.1555599160869;
 Thu, 18 Apr 2019 07:52:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190417181310.27613-1-alison.schofield@intel.com>
In-Reply-To: <20190417181310.27613-1-alison.schofield@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 18 Apr 2019 16:52:30 +0200
Message-ID: <CAJZ5v0gox1FPDcmk4x-QwtJ6r3jo7LWgiEuAYRULHX5QNW6WoA@mail.gmail.com>
Subject: Re: [PATCH] acpi/hmat: Update acpi_hmat_type enum with ACPI_HMAT_TYPE_PROXIMITY
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Robert Moore <robert.moore@intel.com>,
        "Schmauss, Erik" <erik.schmauss@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 8:10 PM Alison Schofield
<alison.schofield@intel.com> wrote:
>
> ACPI 6.3 changed the subtable "Memory Subsystem Address Range Structure"
> to "Memory Proximity Domain Attributes Structure".
>
> Updating and renaming of the structure was included in commit:
> ACPICA: ACPI 6.3: HMAT updates (9a8d961f1ef835b0d338fbe13da03cb424e87ae5)
>
> Rename the enum type to match the subtable and structure naming.
>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Since the original HMAT material is there in the Greg's tree, this one
would need to go into his tree too, so

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/hmat/hmat.c | 4 ++--
>  include/acpi/actbl1.h    | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/hmat/hmat.c b/drivers/acpi/hmat/hmat.c
> index b7824a0309f7..3e32120e2dab 100644
> --- a/drivers/acpi/hmat/hmat.c
> +++ b/drivers/acpi/hmat/hmat.c
> @@ -411,7 +411,7 @@ static int __init hmat_parse_subtable(union acpi_subtable_headers *header,
>                 return -EINVAL;
>
>         switch (hdr->type) {
> -       case ACPI_HMAT_TYPE_ADDRESS_RANGE:
> +       case ACPI_HMAT_TYPE_PROXIMITY:
>                 return hmat_parse_proximity_domain(header, end);
>         case ACPI_HMAT_TYPE_LOCALITY:
>                 return hmat_parse_locality(header, end);
> @@ -649,7 +649,7 @@ static __init int hmat_init(void)
>                 goto out_put;
>         }
>
> -       for (i = ACPI_HMAT_TYPE_ADDRESS_RANGE; i < ACPI_HMAT_TYPE_RESERVED; i++) {
> +       for (i = ACPI_HMAT_TYPE_PROXIMITY; i < ACPI_HMAT_TYPE_RESERVED; i++) {
>                 if (acpi_table_parse_entries(ACPI_SIG_HMAT,
>                                              sizeof(struct acpi_table_hmat), i,
>                                              hmat_parse_subtable, 0) < 0) {
> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> index d14037ddf108..22c039ebc6c5 100644
> --- a/include/acpi/actbl1.h
> +++ b/include/acpi/actbl1.h
> @@ -1395,7 +1395,7 @@ struct acpi_table_hmat {
>  /* Values for HMAT structure types */
>
>  enum acpi_hmat_type {
> -       ACPI_HMAT_TYPE_ADDRESS_RANGE = 0,       /* Memory subsystem address range */
> +       ACPI_HMAT_TYPE_PROXIMITY = 0,   /* Memory proximity domain attributes */
>         ACPI_HMAT_TYPE_LOCALITY = 1,    /* System locality latency and bandwidth information */
>         ACPI_HMAT_TYPE_CACHE = 2,       /* Memory side cache information */
>         ACPI_HMAT_TYPE_RESERVED = 3     /* 3 and greater are reserved */
> --
> 2.14.1
>
