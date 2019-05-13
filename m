Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C3CC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 14:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A3520862
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 14:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729249AbfEMOKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 10:10:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53710 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727640AbfEMOKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 10:10:38 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2AD28C02490D;
        Mon, 13 May 2019 14:10:38 +0000 (UTC)
Received: from flask (unknown [10.40.205.238])
        by smtp.corp.redhat.com (Postfix) with SMTP id 19B0969293;
        Mon, 13 May 2019 14:10:35 +0000 (UTC)
Received: by flask (sSMTP sendmail emulation); Mon, 13 May 2019 16:10:35 +0200
Date:   Mon, 13 May 2019 16:10:35 +0200
From:   Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To:     Marc Haber <mh+linux-kernel@zugschlus.de>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Linux in KVM guest segfaults when hosts runs Linux 5.1
Message-ID: <20190513141034.GA13337@flask>
References: <20190512115302.GM3835@torres.zugschlus.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190512115302.GM3835@torres.zugschlus.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 13 May 2019 14:10:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2019-05-12 13:53+0200, Marc Haber:
> since updating my home desktop machine to kernel 5.1.1, KVM guests
> started on that machine segfault after booting:
[...]
> Any idea short of bisecting?

It has also been spotted by Borislav and the fix [1] should land in the
next kernel update, thanks for the report.

---
1: https://patchwork.kernel.org/patch/10936271/
