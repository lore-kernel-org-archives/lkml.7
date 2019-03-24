Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509E6C10F00
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 15:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B98D20830
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 15:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.ca header.i=@yahoo.ca header.b="d37q/mmC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbfCXPat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 11:30:49 -0400
Received: from sonic311-31.consmr.mail.ir2.yahoo.com ([77.238.176.163]:38105
        "EHLO sonic311-31.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726317AbfCXPat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 11:30:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1553441447; bh=3BTYe0wlCfoSo0zemgqZ21aETVAIwEHFHMSEn5+F3PY=; h=Date:From:Subject:To:Cc:From:Subject; b=d37q/mmCvQ+D03plP/UT+JItgRXOWUMbU5wbl3jkkNV7hKuIsSj/JI4qNqY2bvNf6dInLagN3IX1c5diDKtmepcZcPO3I1m1Ltjfdp5Q/oWBpcJ4X9KeyKTo8u6yqES5wHxEVZaAbvDp6TZFNQT7osakBGrU7T38RuMDXulWuANFNfUYv4MZAB00LRj81rCojU8lH4gp4xA/7RsY8mw919F1/+6TwRFLNoWzWiC90XbP7CBrafRQomGgjI6GZ7DFH+2w0g6nB8U33KU4NZrGyq+nBK2AX9TmTYr0cW387dK3/L35tZg+wp4uGXprCXnOojhqv2jgZ5LiXuczEfQefQ==
X-YMail-OSG: N1cUSN0VM1nWUTKN1bMA6WwcgY45tKGfO5E38VeCuUkdAvKH.GmxcWOCh8Ca0lT
 M3pzkKWCjDLaJDDiprTDzOROt6bPQt4yCsVDvhv4nCgMTM5wgeNGRfpTeNwIIMt4iL23xbR5_28N
 Y6mAyGcUSvlokGjZSqpL.LifPaU0fVtcTCi8CIZMF0ZzwmWNTD.WuAbqu7GxUNy.5x2qZ6zYQRE_
 MZngeccpE9yePcwG4T13PbPjW3.SocMBsLM8muUW1qkIS65w4Lwq1HOtfzWbKSQiP_Fb.y1IWq7b
 mkwMnaoAk9Aconja5KKRvD4cLwp3H1Ex_xsE4fmvRvmRZiYD0qaEWJnV1KXLBdSKmL0F6.Ll7dAz
 3KWpQbnXCc_gh4kpjSJKWDl4PdC91v928OyO1ITn75i4Pr5ktMMTvC4cPTWJf.fMUyRAtbyjX7Iu
 Qrgi4q4qpxFhGGoMo5p4cxvGWZYQnoVNDvqm6V4JaAe8IzOa_sAPV8rV6Q8bKg2OiGw7U.mnNByC
 buSuqAqVqmrSE96e3dM8PeiOZDzfxTBwsWE5W4ijFLfFQxkUcsY7RpE_XILieuccngb7PBRFcl9m
 MzCgUHPxS_00GXdwzBvNk8AHeoMBRr__zOR0oDXR7FV_dSdfnqvgaq9qKDfTz3iF9SwMKhPUWZeb
 x4UYwyz8LDcdAWA2WeNvCgrxVIQXUwWhaarBRwKv_F8hN7Kz7bmmb21TfJaKTEphqYrt_EzQrZLS
 8S8KYMffS6wWXRmarkEMkFtIxDJWtBLRc93Y6YEG_4RaBa6Z32Nlfd8YyH98K2wr6JdS1KutAkiF
 F6H2cywHf8RUFxgC3juo57WuFIn8jyIrikcazyti6AuCVTE5r73OoZu82wsj4V9q60kknuBr3J.S
 uu4yyMinPuUnHYT6xqqtoSX6rx_YbqhUx8dTuhrmXR1QbM0SR8dMZKcEO_eatMF9f8udpLiGVBT.
 P45TsafokONAOs0ub1bwyClWO3ndYq6.xe_0CPA6F0_dRdVfrWO8mvMr5a_LHKCaMG3FDo1I.p4E
 qM5LMf.iang.psbs0q6CQHOMhL65DIYJLDlNn0EV.xHlWopsgllQz
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ir2.yahoo.com with HTTP; Sun, 24 Mar 2019 15:30:47 +0000
Received: from pink.alxu.ca (EHLO localhost) ([198.98.62.56])
          by smtp404.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 6538810d4e26107911f82eb677458271;
          Sun, 24 Mar 2019 15:30:45 +0000 (UTC)
Date:   Sun, 24 Mar 2019 11:30:41 -0400
From:   "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: shmem_recalc_inode: unable to handle kernel NULL pointer dereference
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Kelley Nielsen <kelleynnn@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Rik van Riel <riel@surriel.com>,
        Andrew Morton <akpm@linux-foundation.org>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1553440122.7s759munpm.astroid@alex-desktop.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I get this BUG in 5.1-rc1 sometimes when powering off the machine. I=20
suspect my setup erroneously executes two swapoff+cryptsetup close=20
operations simultaneously, so a race condition is triggered.

I am using a single swap on a plain dm-crypt device on a MBR partition=20
on a SATA drive.

I think the problem is probably related to=20
b56a2d8af9147a4efe4011b60d93779c0461ca97, so CCing the related people.

Thanks,
Alex.
