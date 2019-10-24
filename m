Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C411CA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 10:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA6E72084C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 10:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="fQTpJKMt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407472AbfJXKbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 06:31:06 -0400
Received: from onstation.org ([52.200.56.107]:37172 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404801AbfJXKbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 06:31:05 -0400
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 29D713E951;
        Thu, 24 Oct 2019 10:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1571913064;
        bh=yJXhW2YAvxRlZip0bP5m7RlkRR4+fexngI8FBQ676yw=;
        h=From:To:Cc:Subject:Date:From;
        b=fQTpJKMtXW2dbjwt6j5ka6YgqbZ1crOJ375u/XDBlX+E3kEubIOEidtWfTGO8gd3X
         EmvSEIkaN/JB0j3agUtqEoA36nv91bryIQ4T43hjD0IiWEWLRRNbBKjBXJH6M7WjrF
         AYEZSF7Qb4NU/FGWVajkoWPnVmvHvBZLWGs5bjWw=
From:   Brian Masney <masneyb@onstation.org>
To:     bjorn.andersson@linaro.org, georgi.djakov@linaro.org
Cc:     robh+dt@kernel.org, agross@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        jonathan@marek.ca
Subject: [PATCH v3 0/2] interconnect: qcom: add msm8974 support
Date:   Thu, 24 Oct 2019 06:30:52 -0400
Message-Id: <20191024103054.9770-1-masneyb@onstation.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a patch series that adds interconnect support for the Qualcomm
MSM8974, which is needed so that the GPU can be supported upstream.

The only change in this series is support for more paths that were
hardcoded in the downstream drivers. See patch #2 for details.

Brian Masney (2):
  dt-bindings: interconnect: qcom: add msm8974 bindings
  interconnect: qcom: add msm8974 driver

 .../bindings/interconnect/qcom,msm8974.yaml   |  62 ++
 drivers/interconnect/qcom/Kconfig             |   9 +
 drivers/interconnect/qcom/Makefile            |   2 +
 drivers/interconnect/qcom/msm8974.c           | 784 ++++++++++++++++++
 .../dt-bindings/interconnect/qcom,msm8974.h   | 146 ++++
 5 files changed, 1003 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,msm8974.yaml
 create mode 100644 drivers/interconnect/qcom/msm8974.c
 create mode 100644 include/dt-bindings/interconnect/qcom,msm8974.h

-- 
2.21.0

