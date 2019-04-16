Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73612C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 06:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47E6D2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 06:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbfDPGUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 02:20:19 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.1]:35150 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726895AbfDPGUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 02:20:11 -0400
Received: from [85.158.142.104] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-a.eu-central-1.aws.symcld.net id 96/17-22995-71475BC5; Tue, 16 Apr 2019 06:20:07 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOIsWRWlGSWpSXmKPExsVy8MN7XV3xkq0
  xBkd3qVlMffiEzWL+kXOsFk3fVzNbfLvSwWRxedccNoul1y8yWbTuPcLuwO6xZt4aRo+ds+6y
  e2xa1cnm8XmTXABLFGtmXlJ+RQJrxsJDr9gLWrkqXs5ZztLA+Iy9i5GLQ0hgLaNEY28HSxcjB
  5BTIfHxKFsXIycHr4CLxNEjC9hBbDYBE4lNR/YwgtgsAqoSH3f2sILYwgJ2EucOLGYBsUUEsi
  XuLjsJNpNZYAujxK4NE6EGCUqcnPkErIhZQELi4IsXzCC2kICeRPfkeWCDJATsJaa/v8oMYet
  LvPy6kQnCNpT4PusbC4RtLvHv/S9GCNta4vqHWWwTGAVmIVkxC8mKBYxMqxgtk4oy0zNKchMz
  c3QNDQx0DQ2NdYGkpYleYpVuol5qqW5yal5JUSJQVi+xvFivuDI3OSdFLy+1ZBMjMAJSChkO7
  WD8sjT9EKMkB5OSKG9e6NYYIb6k/JTKjMTijPii0pzU4kOMMhwcShK8BoVAOcGi1PTUirTMHG
  AswqQlOHiURHj/FgGleYsLEnOLM9MhUqcYFaXEeaeAJARAEhmleXBtsPi/xCgrJczLyMDAIMR
  TkFqUm1mCKv+KUZyDUUmYtxlkCk9mXgnc9FdAi5mAFk/RWQ2yuCQRISXVwDhp5yndcqf7Hfqi
  K3/IqrbbZC5c+nCL/vH/x/aWLLAN6E//e/p+VaN81ebrj/10P14t4vofpyjklvqQTcJ44s6jF
  axnOFIuefLdD9Ra397csGfHtGyZp5NOe07n1RMq+HB2/4Kps2TCmxakLzcVWqHn+yyGMdquYf
  lukziX7VO+ZZV8PbHooLUSS3FGoqEWc1FxIgALVVXr+gIAAA==
X-Env-Sender: eric.jeong.opensource@diasemi.com
X-Msg-Ref: server-18.tower-229.messagelabs.com!1555395606!4413668!2
X-Originating-IP: [193.240.239.45]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 20898 invoked from network); 16 Apr 2019 06:20:07 -0000
Received: from unknown (HELO NB-EX-CASHUB01.diasemi.com) (193.240.239.45)
  by server-18.tower-229.messagelabs.com with AES128-SHA256 encrypted SMTP; 16 Apr 2019 06:20:07 -0000
Received: from krsrvapps-01.diasemi.com (10.95.17.50) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.408.0; Tue, 16 Apr 2019 08:20:06 +0200
Received: by krsrvapps-01.diasemi.com (Postfix, from userid 22095)      id
 1B3595F7FE; Tue, 16 Apr 2019 15:20:05 +0900 (KST)
Message-ID: <cover.1555389447.git.eric.jeong.opensource@diasemi.com>
From:   Eric Jeong <eric.jeong.opensource@diasemi.com>
Date:   Tue, 16 Apr 2019 13:37:27 +0900
Subject: [PATCH V1 0/3]  slg51000: regulator driver submission
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     DEVICETREE <devicetree@vger.kernel.org>,
        LINUX-KERNEL <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-ServerInfo: NB-EX-CASHUB01.diasemi.com, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 16.04.2019 01:43:00
X-EXCLAIMER-MD-CONFIG: 8d172408-bd6a-42b1-8e53-daaedf35a5af
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Jeong <eric.jeong.opensource@diasemi.com>

This patch adds support for the Dialog SLG51000 regulator device.

In this patch set the following is provided:

[PATCH V1 1/3] MAINTAINERS file update for SLG51000
[PATCH V1 2/3] SLG51000 DT binding
[PATCH V1 3/3] SLG51000 regulator driver

This patch applies against linux-next and next-20190415 

Thank you,
Eric Jeong, Dialog Semiconductor Ltd.

Eric Jeong (3):
  MAINTAINERS: slg51000 updates to the Dialog Semiconductor search
    terms
  Documentation: devicetree: regulator: add binding for slg51000
  regulator: slg51000: add slg51000 regulator driver

 .../devicetree/bindings/regulator/slg51000.txt     |   88 ++++
 MAINTAINERS                                        |    2 +
 drivers/regulator/Kconfig                          |    9 +
 drivers/regulator/Makefile                         |    1 +
 drivers/regulator/slg51000-regulator.c             |  548 ++++++++++++++++++++
 drivers/regulator/slg51000-regulator.h             |  505 ++++++++++++++++++
 6 files changed, 1153 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/slg51000.txt
 create mode 100644 drivers/regulator/slg51000-regulator.c
 create mode 100644 drivers/regulator/slg51000-regulator.h

-- 
end-of-patch for PATCH V1

