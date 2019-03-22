Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C583C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 10:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 589A721874
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 10:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553250428;
	bh=wb+TkfGGbG7IlDksyqANWBYupnlyZPsNXiMukzjM2l4=;
	h=From:Date:Subject:To:Cc:List-ID:From;
	b=Vameh9e/IG7jmaMQMBySi4JPX2pH1Iyu1O8cG+wF2xQWEhugTOAI4kie93hz5Vfd6
	 5gbz6kNte8KS7I+TEzeLrGTEL/lZgqVij8BL5d/2CRgYLfQkR9nkS/8ZYy0qonrUbT
	 qjULA657huc34FCHZej+kMz/OX9HP68bWxP48xK0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbfCVK1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 06:27:07 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35965 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727739AbfCVK1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 06:27:06 -0400
Received: by mail-oi1-f193.google.com with SMTP id t206so1332263oib.3;
        Fri, 22 Mar 2019 03:27:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=PgW+rQ9wOe65xHIoqowyFCc2NKawp6+fSTZv+pAqQKQ=;
        b=C5WXbkiLpJbWOkFaWuDekLPUlYDwbCf0sfhpKIqqjyjGl0X8wgFc+4UTnQoZWqMUVj
         A3yIaHrSx1GKoMmENjV2LApaoJ3wCs7/xZUX+rs5IufzGQolN88uBsPdFathvrwaiIKn
         7fL3ql6aHxiWKOI6/pCwuS1xEVP/BabGGduCE1d5Vx5PQEraqaNGwz6zIHmrPmsfSSCH
         0yyxLRQ2+kPkmaoveMpFjR51fu3cbgqtQ/K52f1NXf80WmgGNVd93gb/pocrwNX4N0+3
         PxTPRDcOB+2CxeKtUIjGPCh3jFxeLLW8LPfcgcfDjjAW27QHafZxatxwrAWFiNZW9xQu
         I7XA==
X-Gm-Message-State: APjAAAUl4xvWBLH7Mx46YuFvOof8GU+1it4wfRZrV9TtoIuhyNiTEIXV
        aXsNZnApjgd7YUWgUxdwvqEduuqxDbr9LjkkN3VhdYGZ
X-Google-Smtp-Source: APXvYqywbDJ1wHrjBefvHW/HQEz1QqQKkGxkoLh9RZ+6Xf0SxhIjnEttZ3iQZZ/HdckX/mNz2oyurZILL28+TT9+lU0=
X-Received: by 2002:aca:8d3:: with SMTP id 202mr1327222oii.76.1553250425727;
 Fri, 22 Mar 2019 03:27:05 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 22 Mar 2019 11:26:55 +0100
Message-ID: <CAJZ5v0g3_wWoN4Bp1+EKLuNxi3XDp2LrMq21cXCm8FFPoo6FOg@mail.gmail.com>
Subject: [GIT PULL] ACPI fix for v5.1-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.1-rc2

with top-most commit 54e3aca84e571559915998aa6cc05e5ac37c043b

 ACPI / utils: Drop reference in test for device presence

on top of commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b

 Linux 5.1-rc1

to receive an ACPI fix for 5.1-rc2.

This prevents device references acquired by bus_find_device() in
acpi_dev_present() from being leaked (Andy Shevchenko).

Thanks!


---------------

Andy Shevchenko (1):
      ACPI / utils: Drop reference in test for device presence

---------------

 drivers/acpi/utils.c | 1 +
 1 file changed, 1 insertion(+)
