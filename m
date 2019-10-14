Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E574CC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 20:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B357021721
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 20:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="hzzj0QSc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388603AbfJNUrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 16:47:45 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:1654 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727879AbfJNUro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 16:47:44 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5da4def20000>; Mon, 14 Oct 2019 13:47:46 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 14 Oct 2019 13:47:43 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 14 Oct 2019 13:47:43 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 14 Oct
 2019 20:47:43 +0000
Received: from [10.110.48.28] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 14 Oct
 2019 20:47:43 +0000
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
CC:     LKML <linux-kernel@vger.kernel.org>
Subject: Documentation/, SPDX tags, and checkpatch.pl
Message-ID: <124ecffe-25a0-ace6-f106-d9d173c17035@nvidia.com>
Date:   Mon, 14 Oct 2019 13:47:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1571086066; bh=AksvTu/nJ3QRVl8wH0YcaXHhIptrMdGSO337JGt/AoM=;
        h=X-PGP-Universal:To:From:X-Nvconfidentiality:CC:Subject:Message-ID:
         Date:User-Agent:MIME-Version:X-Originating-IP:X-ClientProxiedBy:
         Content-Type:Content-Language:Content-Transfer-Encoding;
        b=hzzj0QScEaNi55SHpLW7ewfe3Z6zAQGFIjAhtxs7DBO1CeDGD4mXdeZ5XtbJmJP0S
         s0A46eB/mYoAMta7/8jbT9vJf00UserNvGrR7rkg4wRAo2wGNdhVzuKjnxwoYpiPRk
         Yd9T5rHHJwwYdhvHMx7ejBTDHswWF9O5BxHm2Ba/QC13LcDeHRg5m1o0q4iJoh2vGJ
         OLfp7jYNu3jVauiytfdU+XoR29HngTOMnGOA+7KkX1d6M+vK0x3eJdVBlAsd8ViJS7
         mnZJ40q0Pknk+lJR7rTCoKFjf3Zz7jqZBICRT2WzsCzRAfGVpBCdD26wkIdwgRmKng
         KVasYttJwZfYA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When adding a new Documentation/ file, checkpatch.pl is warning me
that the SPDX tag is missing. Should checkpatch.pl skip those kinds
of warnings, seeing as how we probably don't intend on putting the
SPDX tags at the top of the Documentation/*.rst files?

Or are we, after all? I'm just looking to get to a warnings-free situation 
here, one way or the other. :)

The exact warning I'm seeing is:

WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
#25: FILE: Documentation/vm/get_user_pages.rst:1:
+.. _get_user_pages:


-- 
thanks,

John Hubbard
NVIDIA
