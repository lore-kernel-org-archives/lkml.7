Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E9AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 186E42146E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="QsWmPVrE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfCMUlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 16:41:18 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:37297 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbfCMUlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 16:41:18 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Mar 2019 16:41:17 EDT
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 4ca562ba
        for <linux-kernel@vger.kernel.org>;
        Wed, 13 Mar 2019 20:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=89R51cBLDNgI7uq+3QtREY+ykcY=; b=QsWmPV
        rETxr8U2KrMtpC2uFtlbE0Yc8D/t3QeHuwgVpcoSnCUka8rvRbtg6TRYuTrHbQnf
        eMIfoi975K9ToW+9j2pE/o+Xn6mm9Qn5jq9v1mLAnMOggeGL1efvWMUD3uON0pvk
        TKRw8uEcspVMq4uk2oyTcAW96o9IzT8jkMxc9t7cFqX6nLejiq78YKzOvQ7/IwQ9
        7+PBVeFefbc52LYJurajIfEJbSCRu2e/x6dVwekG84k/3i0UzirJMhoMKLQtzqX9
        1NvlELsbU7eXnugXCe+7cWnr57MVkTjuVzJfsDYXpuyLTNJ/YzbDCvy1hS+bxCnK
        fK3cSC4ZX6lZRaaw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id bfcd1ea3 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Wed, 13 Mar 2019 20:13:57 +0000 (UTC)
Received: by mail-ot1-f48.google.com with SMTP id e15so3048169otk.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 13:34:36 -0700 (PDT)
X-Gm-Message-State: APjAAAX4Ep3b2+vWfhXz/72sBa+RingSvQagkdVDRlY4kLOpzFQiqAn2
        h68giLAO2/3jruhLOHDNTDpwWoRz6npUe7RyIfc=
X-Google-Smtp-Source: APXvYqxVWD5BGj62Q8jrC2rsU3Sgy9/b480s8Ov6O1de50Y6jofeLq/fKR4/oJMlzEGqMbB1rJt6/mZY1XcQPcIgPnU=
X-Received: by 2002:a9d:5501:: with SMTP id l1mr28756215oth.143.1552509274631;
 Wed, 13 Mar 2019 13:34:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190114201911.13725-1-malat@debian.org> <20190313202429.20797-1-malat@debian.org>
In-Reply-To: <20190313202429.20797-1-malat@debian.org>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 13 Mar 2019 14:34:23 -0600
X-Gmail-Original-Message-ID: <CAHmME9psZb0XoKHjGP23TYsSwMU2G-WN81RKg8AvyY-rZLvy4g@mail.gmail.com>
Message-ID: <CAHmME9psZb0XoKHjGP23TYsSwMU2G-WN81RKg8AvyY-rZLvy4g@mail.gmail.com>
Subject: Re: [PATCH v2] lib/siphash.c: annotate implicit fall throughs
To:     Mathieu Malaterre <malat@debian.org>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conceptually this seems pretty reasonable. Though, style-wise, perhaps
you might want to put those breaks on the next line too, i.e. s/;
break;/;\n\t\tbreak;/?
