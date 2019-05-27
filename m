Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A43C28CBF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 08:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DA502173B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 08:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558946633;
	bh=SPyeTzPFoh+1jcHD1T6EeO+I9ugNzJgCyHNSVSPB+Tc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=AJDEy/YVyltqb3sDj6Zx6aL8dEd7UuRmynQ1hQdMPs1ljGfykVEOTaqI552GHJM2e
	 etGgSwRc5zjs19yJG/vVgkqVZip+nhBCcCPwtiL0sOzu+0U9sKKvWUvIbUMQ9kbHsN
	 hEOtHDQJ1LnOHk57aoXBwNavz7SwdJ0AwI5LRSA8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfE0Inw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 04:43:52 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41282 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfE0Inv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 04:43:51 -0400
Received: by mail-ot1-f67.google.com with SMTP id l25so14128128otp.8;
        Mon, 27 May 2019 01:43:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SPyeTzPFoh+1jcHD1T6EeO+I9ugNzJgCyHNSVSPB+Tc=;
        b=CurKgiqG1W2/kcwqKQGypZEHcqAaKeeiBvQOmycmxO1M+JUNpY1wcado5riTLx4FgG
         KoAuupXk1Co0lLXoLzVZk0CvOYk7xlutqqlEq5DZk3/LMCHkjffnoinnb9e32YvycQy8
         ziXuqUmjx/p/KoWMf47CE+jo966cTxXZ/QZn2/qErM/uzZ6ujgEDVfRRgopAaD6kJKZj
         Thp50xWIEhTq1yDoPNKmKuhGmOQDuMveeVlMnKE+WWRL4hBg2kwXBkVZQse0hRHudESs
         DyuBbNdhcgcC++eX5TnpHOy8uFHrP2P0257cxe/WUfISunfz2lJjT6b48Se2N812QYc+
         6YIQ==
X-Gm-Message-State: APjAAAUPr7GH+9lLtlo50P8cRh7osBh4bF0CR5KFM/Npp13or1BEUC//
        VGOAIkJoib2ZcJWVVgLKoZZY7j4ThLNydZb6Nnw=
X-Google-Smtp-Source: APXvYqxIlLFH84yhUFerMj/YlUDBNDBRTGJTxhPDFRXnfvuo7mYZbz39ugxbhoZlfat/iRijWwRpROWfadWrjYSeMCE=
X-Received: by 2002:a9d:7dd5:: with SMTP id k21mr43860970otn.167.1558946630255;
 Mon, 27 May 2019 01:43:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1558362030.git.mchehab+samsung@kernel.org> <4fd1182b4a41feb2447c7ccde4d7f0a6b3c92686.1558362030.git.mchehab+samsung@kernel.org>
In-Reply-To: <4fd1182b4a41feb2447c7ccde4d7f0a6b3c92686.1558362030.git.mchehab+samsung@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 May 2019 10:43:39 +0200
Message-ID: <CAJZ5v0iiSo=yoyZTt6ddf5fBRGy1wSvzmA-ZaHH33nivkSp22Q@mail.gmail.com>
Subject: Re: [PATCH 10/10] docs: fix broken documentation links
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:EDAC-CORE" <linux-edac@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-gpio@vger.kernel.org, linux-i2c <linux-i2c@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        xen-devel@lists.xenproject.org,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        devel@driverdev.osuosl.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 4:48 PM Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
>
> Mostly due to x86 and acpi conversion, several documentation
> links are still pointing to the old file. Fix them.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

For the ACPI part:

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
