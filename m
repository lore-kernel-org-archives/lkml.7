Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD072C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 05:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE2E24676
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 05:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfLFF5s convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 00:57:48 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:35302 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbfLFF5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 00:57:48 -0500
Received: from mail-pl1-f200.google.com ([209.85.214.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1id6cc-0005Q2-6E
        for linux-kernel@vger.kernel.org; Fri, 06 Dec 2019 05:57:46 +0000
Received: by mail-pl1-f200.google.com with SMTP id a11so2967018plp.21
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 21:57:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=6QtFl09nSid+JllEcjtMOengdLUy/DcEPJvF+2i249o=;
        b=E3KeHHg3s436wydEhsgIPBBgibCz0QhdQUnq+nlBsuiZeHH5SR4zlQxyFoAMLeowZX
         CpVHEZi6geJj8CTv4Ydssd8oJR8dG4YnQiQ+giY7TGpiq5tc0UL3m+Z+kajWBMBQXa0J
         cIOqpCoJCzX/q0OBxCVMTNVjFTlZo4Kw2uHyTNE2NpoWPaRbc7X002Da9Ql1NDM1DcMZ
         JhxbhAx/OEeO2au4w+Vl7qD0vS44tyuow13GmWoHTHSbdUxTNErpxwHmCQJBFZkVqqvu
         3yjwJ4rCMz75kmYytsFjfFEtu5GDkxUVzs7gnuIteBkVvn5z3CswoCoNnZ5IB7KiUoO2
         pMOw==
X-Gm-Message-State: APjAAAWd2mlAGn20/VMl+qXKlPeoyQ1Fr9LRd7vV+a/nO4qTg+u+cHGV
        pdu7b/N2MzuKumKGt27mx2rDTIpYvQBLpt72SFbm/mZZzYJ6FIaYvkWgKCK+bvjjuzPaiG9aEJO
        ECyeq9XXzvFn3QSm2jn9SSGGbb5cKYKwqjeBpfYHpKA==
X-Received: by 2002:a63:4f5c:: with SMTP id p28mr1595530pgl.409.1575611864630;
        Thu, 05 Dec 2019 21:57:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqxpwzCXZBTrYxhlnFEvhDqo8N995kvpUShDhO5qBE99rEBZ7AsxOo9MkgDPfLC5V9zwBYSYNg==
X-Received: by 2002:a63:4f5c:: with SMTP id p28mr1595519pgl.409.1575611864341;
        Thu, 05 Dec 2019 21:57:44 -0800 (PST)
Received: from 2001-b011-380f-3c42-d14c-a8f0-9761-234f.dynamic-ip6.hinet.net (2001-b011-380f-3c42-d14c-a8f0-9761-234f.dynamic-ip6.hinet.net. [2001:b011:380f:3c42:d14c:a8f0:9761:234f])
        by smtp.gmail.com with ESMTPSA id s130sm13560628pgc.82.2019.12.05.21.57.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Dec 2019 21:57:43 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH v2] iommu/amd: Disable IOMMU on Stoney Ridge systems
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20191202170011.GC30032@infradead.org>
Date:   Fri, 6 Dec 2019 13:57:41 +0800
Cc:     Christoph Hellwig <hch@infradead.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        iommu@lists.linux-foundation.org,
        Kernel development list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <974A8EB3-70B6-4A33-B36C-CFF69464493C@canonical.com>
References: <20191129142154.29658-1-kai.heng.feng@canonical.com>
 <20191202170011.GC30032@infradead.org>
To:     Joerg Roedel <joro@8bytes.org>
X-Mailer: Apple Mail (2.3601.0.10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

> On Dec 3, 2019, at 01:00, Christoph Hellwig <hch@infradead.org> wrote:
> 
> On Fri, Nov 29, 2019 at 10:21:54PM +0800, Kai-Heng Feng wrote:
>> Serious screen flickering when Stoney Ridge outputs to a 4K monitor.
>> 
>> According to Alex Deucher, IOMMU isn't enabled on Windows, so let's do
>> the same here to avoid screen flickering on 4K monitor.
> 
> Disabling the IOMMU entirely seem pretty severe.  Isn't it enough to
> identity map the GPU device?

Ok, there's set_device_exclusion_range() to exclude the device from IOMMU.
However I don't know how to generate range_start and range_length, which are read from ACPI.

Can you please give me some advice here?

Kai-Henge
