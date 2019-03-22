Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA1B4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 10:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7931C21874
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 10:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553250501;
	bh=iKr4d+9CDxuKto9/gsDbiCrLXdxCEHxm2JAjxw4sM3Y=;
	h=From:Date:Subject:To:Cc:List-ID:From;
	b=GttbVIa645U3FUrs5rcPntxmWhAugRmxQnpqaHrKfHJfvmgGztUzbyu0Cr43UAz0I
	 VhyLdx5ZqeK7yfenEMg1RonZRyCBcyvAB2SvbGnGtbxUpglcwFrGzOLt0AgM3463Bw
	 0LQxfxvFx2hcAsEImyIvW625JpFK+QMDEj8fZKkw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbfCVK2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 06:28:20 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38643 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727739AbfCVK2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 06:28:19 -0400
Received: by mail-ot1-f67.google.com with SMTP id e80so1475469ote.5;
        Fri, 22 Mar 2019 03:28:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=elHykPYN2bpDNdYbHd7n+k6DCnnNEnK+sfeC+gWZLts=;
        b=qss36nuwpIiYm2MEkOnnk8+P4ZTDEu2XyM4jQPKXYKCfT1u4i3IiWtfBn+PsqFo35y
         dR3NW3mVcFVuLVJvfCqPMibY84beFG29/bkg+9iOyIM6yV/yNd1+8NqcedY/14mchcAz
         gklDe/ctZMSufmV9eg91Csy9jTxofH1qTy8MaV51bNlf9iDoNysQag6SiUqPyRsOZhr+
         kDS7xIDMe5AmbuS4TH+hgFS7GbJvQ2hL5eygwD45O+vbRqLL93CpwxNNh+hCUck6E767
         NutA+4O225sYXQRdph9WFy1gYWcvnI7Gzizj+BJtkBz+J+Md/yxoTuUn2T1QckXXxax5
         i/NA==
X-Gm-Message-State: APjAAAVTSQc+lha1T0v32ktwZasNo8TAPK3ocmaaEMwTwI0VlKYJP3Hf
        XMREROoHdHUOI5cWEdoyAb0sBO2EqX9x1lpGmGUAbbGK
X-Google-Smtp-Source: APXvYqxtFNukVNHkQun1344roAerIMWFt3A4NByASfcOF7QmBn+ZS7YPg2X0xhlB0cDtgDjeNNsmipAnZsQ6IwgGtFc=
X-Received: by 2002:a9d:36a:: with SMTP id 97mr5798160otv.124.1553250499236;
 Fri, 22 Mar 2019 03:28:19 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 22 Mar 2019 11:28:08 +0100
Message-ID: <CAJZ5v0i5Jy9sAXLQX-Wap5qW6_sw+CW9JOx4t8E=hazK39_xHw@mail.gmail.com>
Subject: [GIT PULL] Device properties framework fix for v5.1-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 devprop-5.1-rc2

with top-most commit 0e3edd94448001a33ed7f8af2179cd4a280348a2

 drivers: base: swnode: Make two functions static

on top of commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b

 Linux 5.1-rc1

to receive a device properties framework fix for 5.1-rc2.

This adds missing "static" in two places (YueHaibing).

Thanks!


---------------

YueHaibing (1):
      drivers: base: swnode: Make two functions static

---------------

 drivers/base/swnode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
