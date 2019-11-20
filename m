Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863ECC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 11:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AE8721906
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 11:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="WWmfwRyA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbfKTLjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 06:39:00 -0500
Received: from mout.gmx.net ([212.227.15.15]:44181 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728184AbfKTLjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 06:39:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574249930;
        bh=lqyqM/sKrmql+PwHb90YqnUSZovmLvHDKIXNfQX0XeU=;
        h=X-UI-Sender-Class:To:From:Subject:Date;
        b=WWmfwRyAjcV8ViIpjf/CrABvhxI6lIzVC28U0o3AQh0byXlqRqaouAupHjXf4tDpx
         FNHnFk2d/kwDVW8Uai5hFSwGfHS27y5awF5KidbFTHo2nqJnMI3/QveXQzp32Ci2OO
         Yq4roVRyiSLnlofCipjzRSdfhfsSSL/R+jlhG1gM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.176] ([37.4.249.139]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mz9Un-1hch4L3AFX-00wDIF; Wed, 20
 Nov 2019 12:38:50 +0100
To:     linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
From:   Stefan Wahren <wahrenst@gmx.net>
Subject: BCM2835 maintainership
Message-ID: <68580738-4ecf-3bb7-5720-6e5b6dafcfeb@gmx.net>
Date:   Wed, 20 Nov 2019 12:38:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:NppHBscTU5hFATj15+QdozwTQz+xRqNmlaXDy40FziLle98rbmP
 KIFr7e4mAKiQVE7zB4E3NiFBPguRs/7U7ORwGbL6Rr7RBD4CrBcQASbssUkQWFmHu1RuHpO
 me23qknFZ0BVIRsPMnR0FH3qU1FRHRhTsjYJameCjwBiAJw7MNO/AITyzKcAuzobUyTdpvX
 Cjls8R8+zM+gJSnZxU78w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:M+omUdPv3xY=:hhPaWjXE4xbat3U20/FSm4
 iO1khFenmQgYrl/fnqeF5nh2XZcYcFofP/8BXl4uM6J1EUY7HaOXn9VV+rwpJLXAA2Iib52S5
 eL4qPkKJflGhekCqxtM2gEAd9t8ymwrtL4oF1DWbOvSwQXnVqluR4xT2YU/58WkgmHcLt2Epu
 xcuyF4BhlXGXy9oq0DGvz08PyT1J9aTHoGpIksNaz50z304/hnUo+FwAIBRxzb/Mn4yveznH3
 ARkBX10atW1IigzBAOonG/aFJI3RSsnRAYO4/6t3/Gfkik8Fcw8E72z1Qk7slQQz+mYNzcwz3
 zyeDBEzAI4j0NMq+ypM+4DVpC9864tSfmTxmTIFHqWZ+E2Gl3j4gp7HifBN2lq7tAzFBYf6YW
 2JoshHyBjUuYdvrUMcZPSp9FP4+vwlAiyXyrWZgB6GXDyf8rvfEljFEtO6MK8Pt0JccWUdRny
 cK5+qS1FjW/MPX/lioI+LUdSVLSM/jVW50+PiGY/ilf4OWN5c/Uj2sNnhZR+nzdoqQdiyn5yj
 MtOT955dvay3oLP6I4yLbbHrYOArf3ZvexeubYjYSBF4InnnYdp9TBceO3TLnbMwO29LJrSHm
 pmiVid/xo7FYV+0gj+oB9mzVJAHILEf+3RE6iKxZe4NnExzJUzU9MnJ3+VDN/BUWYJKJe8+sK
 hS+ZEe//98nUp/d77p4X5Z0oGOt5HCpv0MLpfvLj5WpVNdEe+1I62vHTDlqbuAEdHl79mH+uG
 XICH7hC9V+v/YOXyh6wKwhBJyGR6E1Dx0Q9u/DaaduAUds94RPlL/g3d1jC6P947LFNvflKH1
 nTPjZFq+axacpM7/+FmhTuA3bS/VdRrb2jsVOvbTL2hL2w+FYYCdIEM1qYyCTv/lyKl0GPRvR
 3OsGBGpwYFyHVSt+Cd3NEZC+OO4EWcKGJYlT/lai0jUEGNEgsD8+AzKiE42vDAjPgZj9IvU22
 D36IaWBstdLM/UKAmRC7Ourif5v7Jwk9TWgemyVNw+z58xMIcXsqbH85Ab+8UOIe3ePgq+b87
 u0OxX4fKAlg6eVmNfUBiz797VOzlD3Juj1+8hAcoL04aGhBiZbBNuLGVbhfLgqCGuIa6+lToX
 e7bhApcjV+g/5lpiOJHyEzqRVVpL62jqIEdAmbV9UaA/l3YeMVERXUj7NMotjif1pXsk3Adwf
 UhTa5vAYxeYu/3n6Lh9Kamb2uPs5+G7zT/FmeQwWedNSeunnt7Uzr5LRWr+Dcdeb7kjpU5Xst
 nS5PDp/sgEfJp6VJ9mZxXtO5qDzQ7zYgls7GePax4so1pUG0auOKoBByhqzg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

i need to announce that i step back as BCM2835 maintainer with the end
of this year. Maintainership was a fun ride, but at the end i noticed
that it needed more time for doing it properly than my available spare time.

Nicolas Saenz Julienne is pleased be my successor and i wish him all the
best on his way.

Finally i want to thank all the countless contributors and maintainers
for helping to integrate the Raspberry Pi into the mainline Kernel.

Regards
Stefan

