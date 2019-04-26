Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44ECEC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26220208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfDZTB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 15:01:28 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:38201 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfDZTB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 15:01:28 -0400
Received: from orion.localdomain ([95.117.100.117]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MeD1l-1glJB31sZz-00bNrT; Fri, 26 Apr 2019 21:01:26 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Subject: gpio-keys-polled improvements v2
Date:   Fri, 26 Apr 2019 21:01:19 +0200
Message-Id: <1556305282-24148-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:o25NK8nTpvzsP9XrlcKg867BkLaCrBxZXGUeSawGfaeYvWvnUxt
 uXMRW5hU0WQ4EpzAW5vKncRdS5Ri5PpZ/Wtgeb38BiryS7WxonsS/Xx2t7ATqkWVRY9OF4X
 YE4u1Z6vCu2qM/XW2dKsIyfF2xAkvf/fo+u6gpxlrJfR6rO4exyg1fx/Z3NnPIrZixQzkCp
 v/5iXzRgc81b0ZXUcFgzw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:S11xkao8vKU=:gSC2ZFNTTk2iLGSh09yILh
 nsr8NgwEijdc1NGRBSXjHq7csKPQ7o/k6swY+YC3kDgQqZyu5yXqnjMRDpuD0Mk7TtTtIJbPI
 r8Dl6n2awrHOl4+4ZTMgHEI5xUMreDiDMbTdQfSQ+/fULYVvwd8egFzXVptfkbDIntOUBXNZK
 HTaYCD8XYLaM296yZVK2pFb6dHqxKXkr3x9nnOCNqe99aAflfV1p9WNxUOd5xS8/zP3Wssxq+
 woqPhxQdunC0q42cWNR/g0Tp8EsPt9LCfYOYFJrnwGvk+tiQjJpCtlp9iuJUnqnupLS53zIFg
 LMsY+AnIQhAvzlusIAmc5+c+pV9sgxEhy50lhdR/LoEXSw4h/5u++X9WZsXD7lkt8YvVevNum
 akp5XINRQ0lcu44CzkhnJgcJkiaZeGk5coL9lCdEAknqkui7zR5MX9eT/OXYD0bWCk4rAFWBo
 iDRGmDPDfOu6Eih6lwamtmteE6v3M/+mTMVVYz+vBdiMVUuIXFb1Rm5LaF94HSX6mQWyh4rJp
 X+a9uI4clESYDSKJDcohHLB9HDUEXjpi4K30n7yh1Byib0wKztDrWO16IUNNAvOoW9K7J3eIQ
 g6SoyGEYlzWHlXFwsAC103OHzWPufAbOZdaldyDgXHacOg/RWsdZoXn/8Cj+uRjq6udaHuu0y
 Elae8KGDFmyrMDJGm/9rpXGPa5zPJcHPVHtA5Y//brWxqPWbIkzcpgRmBWJHXrhxvBE1ZY7Ex
 TNm3YSyDVo2ktNhlOYI/ZfEyX9/1opI2ZYQRqw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello folks,

here's v2 of my gpio-keys-polled queue.

changes v2:

* removed the change in mod_devicetable.h
  (MODULE_DEVICE_TABLE_OF macro)
* reworked the patch for building w/o oftree, so it works
  w/o the MODULE_DEVICE_TABLE_OF macro

have fun,

--mtx
