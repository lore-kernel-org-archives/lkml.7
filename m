Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC297C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B62C8205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555600045;
	bh=MUhdhFrOLM4zcc4C4CsZIl2+GLyD2pt4jCtnmd9DaK4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KHnnO0GEuVFz4yQ3a+mh9CWMmAfoQojxulfYtNmA0FmxHmingIrjPzb4WgPEZsUra
	 fzbzfEGiOxz6GJdvaQONsWQcrsfo5ZwUTKjbYg7rHNb0Y0MZ28XFw/rLoEy+SY+K1E
	 bnij0ljziPYsu/WihVnHoGEzlLF4ZuX5Ncv8e5j8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389432AbfDRPHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 11:07:24 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37355 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389141AbfDRPHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 11:07:24 -0400
Received: by mail-oi1-f194.google.com with SMTP id v84so1863242oif.4;
        Thu, 18 Apr 2019 08:07:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MUhdhFrOLM4zcc4C4CsZIl2+GLyD2pt4jCtnmd9DaK4=;
        b=tU7GTQ22vRr1vwO0MtH2G05n+E16tQ5K7gSMnW3XN3oViQ9lkVDt8UaIjpT8TCWLF9
         C94g1QLEuwc9fAx98dVIkEIuUsX03kb7n9KJZO1oME8i4Fb20zVck8fG8WnRjrZFQIqj
         Pw8uC0jMiKyv/M0WB8K20PecCZVWxCYEUbavKCJc+fe4hq1lWABVo0Si89+wKMTDehJj
         2mNbfpnwoEiPsSScMl+o4DvFfdG6F2jsHL1frXmvRkIWpzAoi9ofUJ9fbDmsjhTWuDG2
         jS1XDsrrmZSTHZNM58PA5WdDXzGNSpjcZvdcr5XUqk9y9iYDi/Nc3H7fektVf54QPpFe
         AsMQ==
X-Gm-Message-State: APjAAAWDqx7kDPjkqJBjn2yedYAYe9KnFJKn4yCwrIFC55kZ9N/jUgpG
        xBZ6/jLTuwrQkg2T97Kfh4zP+GvR19i9FKM3+GzOhA==
X-Google-Smtp-Source: APXvYqyf06lSGGJZvjXf57aOXckOfNwtOToTZ7LYtWQ4NrH5rRlG4Xz39OTc10mZNbVZOnc/M28WeD2MnSWsoGWi2Kg=
X-Received: by 2002:aca:ab06:: with SMTP id u6mr2133902oie.68.1555600043240;
 Thu, 18 Apr 2019 08:07:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190417181310.27613-1-alison.schofield@intel.com> <20190418145640.GA7659@localhost.localdomain>
In-Reply-To: <20190418145640.GA7659@localhost.localdomain>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 18 Apr 2019 17:07:12 +0200
Message-ID: <CAJZ5v0g1EZbzr6BJhVBVb8JZGnVQg2Sz8NHtz_0Ji9R_58wMbA@mail.gmail.com>
Subject: Re: [PATCH] acpi/hmat: Update acpi_hmat_type enum with ACPI_HMAT_TYPE_PROXIMITY
To:     Keith Busch <keith.busch@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Robert Moore <robert.moore@intel.com>,
        "Schmauss, Erik" <erik.schmauss@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 5:02 PM Keith Busch <keith.busch@intel.com> wrote:
>
> On Wed, Apr 17, 2019 at 11:13:10AM -0700, Alison Schofield wrote:
> > ACPI 6.3 changed the subtable "Memory Subsystem Address Range Structure"
> > to "Memory Proximity Domain Attributes Structure".
> >
> > Updating and renaming of the structure was included in commit:
> > ACPICA: ACPI 6.3: HMAT updates (9a8d961f1ef835b0d338fbe13da03cb424e87ae5)
>
> I was not really happy with that HMAT update. Platforms implementing
> 6.2's HMAT continue to exist even if 6.3 isn't backward compatible. We
> just lost the original subtable definition.

Well, that's true, sadly, but the question is what to do in the kernel.

Definitely, the 6.3 format needs to be supported, but if the 6.2 ships
anywhere in practice, that will need to be supported too.
