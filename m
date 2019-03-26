Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B442CC10F05
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ED852075E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731488AbfCZMbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 08:31:15 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:46691 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbfCZMbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 08:31:15 -0400
Received: from localhost ([89.247.163.190]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M9WiK-1h5Rpr0CG4-005XrZ; Tue, 26 Mar 2019 13:30:47 +0100
Date:   Tue, 26 Mar 2019 13:30:45 +0100
From:   Andreas Klinger <ak@it-klinger.de>
To:     jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] transform devantech-srf04.txt into yaml format
Message-ID: <20190326123044.putlbpnkecsley5q@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:wxvdyAmeitSrJPSc+uUf7IGBCvnnOdU2/hCNWmUCMNBHrRYHbcN
 6v8PhyGf61MWIeO5Oa0RyTr58QdwC1MmNEEtJRE0teMJ93fYa+nsKE9XUamyvTrJ2Uvi8+K
 zELzPoM1NnlnUVEbrqIXrg38LEWiMZp3xz1NTrtCIPJzUoYNsgcZqXWWqgIjwnj5bHsVXfV
 JbKGJzj1oZiTPVkxcIcBg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RCf9Ww5LXdY=:sv1PdiTEWjfRWvRheHARvH
 RyNtI7bU8mevUseaKHTErBct62te5KXZ3kjUQYe8F9CSnvlM+xCa2kUxzdyy58DzjNTw42QFz
 og9xU/oyhSMBSvK+KfXLEgf9yXCtvlBjLXUEyS4T9SuFfIxtI9E0pqwT8Gb3i6bH+GIk11PpG
 UvPqrlkpguOuGvl2kG8rvfmIesQs2tfuMiyMide2ZHZ8udWkXji/LFL8ywCJgz8ddIhgj5a/j
 ihxsPbAAc7HuiFP5bUE2wPSeshagEEhnvM2J2YTx2fJVUi5gkKdE+qXvjZzNMsfczPBy0NKJL
 jDfMb+gtmzaIhs/Xb1bHu3WM9357H84zIHX3nPhbv9oqKndTQ1dLj/p/2QqnN+nd+0wr/5drE
 5pPmfS2AXlamZghc7vMfr1F7/mjkquuxY208sMCWsc++JiferxIPHxq9ZnVhsPC/mmixrBiRi
 a3qnxqYGglEcxQARwI0g33gXEOB1GD7X1qkdI/8DTd9StNOnCYc+m2N9mefJt5w/rx01eZXO0
 3wTKokRzw87NsLGhcuPpJajBa4PcgWmw1pzqAuIOpuHTVH+EWMbMM0jv/Wh2nEda3r2VClH4t
 qMO2hVhdqsikxPO4RrHxC+9rv2J2jZFt5xQciXrxVmeYYhkNYK/gT0AND7NlcE0BPwMJ5t+BQ
 tDbyYeLJaPgthXbzJCnFzzDwZivxk7KX2JUPGmQTQUI7cbtMmr3icktmocsUfY0zDiC244Hle
 RHlOVXNqiCVMp/b/2z9bbXl/G8zoH0aqH3G6qw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use yaml description language to document Devantech SRF04 ultrasonic iio
proximity driver

Andreas Klinger (2):
  devantech-srf04.yaml: transform DT binding to YAML
  devantech-srf04.txt: remove old DT documentation

 .../bindings/iio/proximity/devantech-srf04.txt     | 28 ----------
 .../bindings/iio/proximity/devantech-srf04.yaml    | 62 ++++++++++++++++++++++
 2 files changed, 62 insertions(+), 28 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/proximity/devantech-srf04.txt
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml

-- 
2.11.0


-- 
Andreas Klinger
Grabenreith 27
84508 Burgkirchen
+49 8623 919966
ak@it-klinger.de
www.it-klinger.de
www.grabenreith.de
