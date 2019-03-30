Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1536DC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 09:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D80F5218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 09:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553939523;
	bh=R1wnTyYHKBdrpMuOnPY6PjkthVhGnJmHch4A+C6pfl0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0J3fHpamilPp9oVfzQI4Gpe1aJZoTZVEtX3slIOgX/kEIE9eXWiqfJKuYGsxRIQHw
	 y83xTcOUaemM9Y1uz7YMD8La/jdGjgDFCeOzKC3UT/2McTc0x+qIkAeX4WPZ7INav1
	 vuj/u+/p/3+s6SsMISQyLK0D/vIAn4HJmWzD6L/Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730610AbfC3JwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 05:52:02 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41225 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730384AbfC3JwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 05:52:02 -0400
Received: by mail-ot1-f66.google.com with SMTP id 64so4274732otb.8;
        Sat, 30 Mar 2019 02:52:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1fLAfCJZ4QHKKG92hhSU0p1/0Zr1BKU3DdRY30fp6io=;
        b=f5dfdDAqfjchIgOnEw7/WqXuKrf/OdEl9HLyNMLlepq/0/RfN+fX/d5csHvTdOnhzV
         ipVMaI2Cu7j4lmVkC7iDrFJq5V6Bskael389deAPZMGqcOn6MnME6c+xfFlvImB6yZM+
         RSPOqP1qCvv2/2mWWzYZwvY0IyWokhIGWXYLXFoOQdCjEgmudVnYp31XqRaqEqoGmTmA
         8Nk55qbZ7osZHKBIFsvYnSrOv0oR2sFUxrhdWebxMicEx8aeM0y7EjaOGrNzrpshvO9i
         VL5156MjS4ypUzHjWvpeevtGPNBvppldSM0S6qFvkzRSZY/U8WKw6xJcnUfxTjAizEOp
         d+sg==
X-Gm-Message-State: APjAAAUP89GEjUaX8F+l4hn2clldZtFbykqpctq7lT6pX+92D1GMsoTP
        3ZcckFJABniIf7MmLSFLIbJ6TQ2u8tvPjCRpWcE=
X-Google-Smtp-Source: APXvYqzO7u0xqEu0Azh++fVbXO7beF7FImkAq/G2mXSyY9/IOnLs5KmOxEFfIztZlj2Y/pmyn8AMjApnBAe/TImymE0=
X-Received: by 2002:a05:6830:1592:: with SMTP id i18mr9921992otr.244.1553939521407;
 Sat, 30 Mar 2019 02:52:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190329001135.15847-1-changbin.du@gmail.com> <20190329001135.15847-2-changbin.du@gmail.com>
In-Reply-To: <20190329001135.15847-2-changbin.du@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 30 Mar 2019 10:51:50 +0100
Message-ID: <CAJZ5v0h=tpzWJrt02ET28EG9hn6eSusLV68FZCV8nnXHDBxHEQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/24] Documentation: add Linux ACPI to Sphinx TOC tree
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 1:12 AM Changbin Du <changbin.du@gmail.com> wrote:
>
> Add a index.rst for trace subsystem. More docs will be added later.
>
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  Documentation/acpi/index.rst | 8 ++++++++
>  Documentation/index.rst      | 1 +
>  2 files changed, 9 insertions(+)
>  create mode 100644 Documentation/acpi/index.rst
>
> diff --git a/Documentation/acpi/index.rst b/Documentation/acpi/index.rst
> new file mode 100644
> index 000000000000..7241ceb1673c
> --- /dev/null
> +++ b/Documentation/acpi/index.rst
> @@ -0,0 +1,8 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=======================================================
> +Linux ACPI (Advanced Configuration and Power Interface)

"Linux ACPI Support", please.

> +=======================================================
> +
> +.. toctree::
> +   :maxdepth: 2
> diff --git a/Documentation/index.rst b/Documentation/index.rst
> index 80a421cb935e..e3aa28275894 100644
> --- a/Documentation/index.rst
> +++ b/Documentation/index.rst
> @@ -90,6 +90,7 @@ needed).
>     filesystems/index
>     vm/index
>     bpf/index
> +   acpi/index
>     misc-devices/index
>
>  Architecture-specific documentation
> --
> 2.20.1
>
