Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711FBCA9ED1
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 12:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5458F208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 12:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730530AbfKAMP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 08:15:29 -0400
Received: from alexa-out-blr-01.qualcomm.com ([103.229.18.197]:25192 "EHLO
        alexa-out-blr-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727329AbfKAMP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 08:15:29 -0400
X-Greylist: delayed 367 seconds by postgrey-1.27 at vger.kernel.org; Fri, 01 Nov 2019 08:15:27 EDT
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by alexa-out-blr-01.qualcomm.com with ESMTP/TLS/AES256-SHA; 01 Nov 2019 17:38:48 +0530
IronPort-SDR: /VdXvRb+/5cKj/kyt39JtSBtxZtazGgnOoGurMFTmCrzm9+/vj/Jpz7TDZ0CACxlJXgXMb5S0e
 4U+EcZ5hDIgzxTZ6a1pOb5Fr8pXjqId7ryVN8J5Ns0Dr6UZ+MWLh36tItJGj90tEhYnj8BYi6Q
 QZwMr6XkZxlkrMX/V53ZTLz3G28LcviF1EXZRGHZ3Lzx+GiC+PU8jkuPFsiiisG+W56c04fgF0
 LyBXdqeA4ACjASh2+MwXEtD5Dxz14p+U85Fov9cnR9jNp6bi8jNhmHPagfJUtCZdRGtEtYse58
 QnekzNXvvxuQdmXt8nsx8HeG
Received: from c-rkambl-linux1.qualcomm.com ([10.242.50.190])
  by ironmsg01-blr.qualcomm.com with ESMTP; 01 Nov 2019 17:38:33 +0530
Received: by c-rkambl-linux1.qualcomm.com (Postfix, from userid 2344811)
        id 3E2E818F1; Fri,  1 Nov 2019 17:38:32 +0530 (IST)
From:   Rajeshwari <rkambl@codeaurora.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sivaa@codeaurora.org,
        sanm@codeaurora.org, Rajeshwari <rkambl@codeaurora.org>
Subject: [PATCH 0/1] Add device node support for TSENS.
Date:   Fri,  1 Nov 2019 17:38:27 +0530
Message-Id: <1572610108-1363-1-git-send-email-rkambl@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add TSENS node and user thermal zone configurations for TSENS sensors 
in SC7180.

The change has dependency on adding device tree support for sc7180 [1] 
to merge first.

Dependencies:

[1] https://lkml.org/lkml/2019/10/23/223

Rajeshwari (1):
  arm64: dts: qcom: sc7180:  Add device node support for TSENS in SC7180

 arch/arm64/boot/dts/qcom/sc7180.dtsi | 518 +++++++++++++++++++++++++++++++++++
 1 file changed, 518 insertions(+)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

