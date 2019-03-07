Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46857C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 02:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A52120675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 02:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfCGC20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 21:28:26 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:32777 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfCGC20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 21:28:26 -0500
Received: from orion.localdomain ([95.118.27.116]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MBDrM-1hEQ5f0Mv8-00CiD7 for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019
 03:28:25 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: git-send-patch v2
Date:   Thu,  7 Mar 2019 03:28:18 +0100
Message-Id: <1551925699-22445-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1551895583-11955-1-git-send-email-info@metux.net>
References: <1551895583-11955-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:3HiaqDfoYpRcjdjQjy5S8pW2oq5vjOnodZ2xVlbTDx2PQYflZXm
 AF0rKgkilovGmcjaWfothfuIBkRWWm5ZQ8MAyIrMpjGGCeXKGOWVPGHql/XNouNGxDRdWj6
 fZqejTTfpzejLsENll/MHEBCJCL793iUMOCL3xPZKpEvNhJjQEFG87Z21pxn6hIhRErY9vy
 A2BKRXamyQR0gxQUz0jMw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qXG7cRxDLgo=:uDcuPq2Jqyy1EcQuImD2wv
 DNym9G2MSTXWwgml2ZXB0KL48jvfp4ZEENjeFTMm2qp31ADbjR+nAJgd45YFxSU1abnEjek0W
 hPqbTVQKcnireUy0PxAGSvkg/z+8fDvL6p8gtAEjXnLhv5Iewy7kcahTNSg9zquAmiyQ2bbhX
 p50BF3ohzAeUG0xkPSX3u+9ugi+/Z7w63VSoXMHNPakhwePhEAsIa4ZV+v8hhv0cRU6rr2Opi
 WpMX66SueVTjprqRwL28rsp9eiqseAIuNoqA/cqO3TVg0BDYfwyoAOn63RHTUNKkUWB3FJ6r6
 J+e5NUbBwVj/k02IgT7L8/jB5KzJ2i4YPMkllEdd7pZrP+MQyNPU/e48vYMq30x9A8BjxPfbX
 DwfsCxN3qgPFvn9f+yp1rEgJtWauZdUameV9lhpfWsIexj3/rBosf3DiXPVWgjBUFIGn/HTgR
 OI8Jk7PMkjriWrkXwkMx+PxAaNTFrP65yeRMsYomnaLMVc9ro4+miIq5GCYsJIC1pI0aRgRZM
 P63JXo5MYVVXJHtBCq/j5ltouKHeZIQe+9O5BiU8hqEMDwIdG1DGeVWUz0OC0wU5udXEqhDzo
 L950Ha9Z+X8npRpjor8lbY83xGvAK1E6CJj6UWzijRB6F6IZ2KZ6e06LLZjjka1DrscsdCUt0
 84gfjGq0c87LkbduFwHljRmzB1MPErRdKma9InhSBtd0TQWptW4t9q0f2uVkPDSoBOPzoK6no
 V//XHqSuZc0zjyskm/jgA1AptmgnDzW5Wx/GOQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's v2 of my little helper for sending patches to maintainers.

changes v2:
    - don't check for topdir 'firmware', which had been removed recently


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
