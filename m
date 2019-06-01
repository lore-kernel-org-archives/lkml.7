Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E58D4C28CC4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 14:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF66524658
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 14:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfFAOCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 10:02:44 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:52767 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbfFAOCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 10:02:42 -0400
Received: from orion.localdomain ([95.114.112.19]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MuUrM-1gfeyh2gPS-00rU8U; Sat, 01 Jun 2019 16:01:45 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org, jdelvare@suse.com,
        linux@roeck-us.net, khalid@gonehiking.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, aacraid@microsemi.com,
        linux-pm@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: remove unneeded #ifdef MODULE
Date:   Sat,  1 Jun 2019 16:01:37 +0200
Message-Id: <1559397700-15585-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:hGTgP1y7zY+DVXA/rOYqRPbljVCiVHRqPra8wSw4Lkfo1xHjwNn
 eK9ZzEYzFoatUXTklAva012EmlLrpLSb5plOGiEEGxCWI39nTOi/JdUF5xvW8bmZeubpcSc
 xc8pnImbQFOUGhhWZLVGngY7hE7GncvcAlxymgO3klVT6wdQkYncmMKsMOeeuEsQKS0QShc
 StwfyiM1ZO9f+Gk1pPJCg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:d0/aFr6L5/Q=:dJYAEC1kzUKCKAKaj1w7ME
 FSAvSirVALQTSLvxpmanuY0cyWrJUEcUF64D/ArKTxkOK9sw2FxEmipp29+ADmoAMKkAxUSWM
 VlUckQ3W5mhQCPS4OG22rHvGAZRHAGVGC58h3bOQJVCcg7r3c9ZaH3MFIswYfqDg39zG0919Y
 H6oRs1tUaGqdL6Xy9zaStkgTtFHs7hOeIlGU17FEpdA4wQQFxyihmCcKhIDooSxeJBeDOE5xW
 svi/gvFfIWe/QO8LpJyCyp9FMnHg47NcutYWxd5yvDyXdrS+73TWw/aOiWkg2VZiVCQs8Gcoy
 q9H27W7399HD88fTcZBIv7uyWmk9dODuqr1PoJ0NAgBnEWnS1uYisLZ+QN8oJKlBSa/EgKyn3
 OyScGXWW/H0E4OkggsSp6DVYsn1KPBQXKEt+zTO2lTrHdFiqisk24EfmeMrSqSrWcY7CIvHFe
 kJHhQZ+TiS5EXEACMa/24cIN9Rz5U7L8RmmY3FXdEL1nvmP0zlBlRFXPdWQn9zvxPFLDksBfU
 m1uVq6R/tOm6U3rkF+qAB7lOIkI5nbN4B5JH3y0XFQF5sJRG5ooKitxAjLNEFhWryzGiHij4h
 5zp4maKCCbi83lNTcfG9AS2VdVUzpSyH8jqtOVUO0G9elkHJCIRrVR3bwE/49TXOcBB+WQ+MI
 GVtfS40Gbg/noJkoNf3q6cdxwX545eiBElw20LPpVnpLl8a1ZHpDU7CMANVsa/epfhWqPgh3U
 Uy4qF0JDswsG9vefLymMZZohFAAWJpuiTzibPw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

here're some patches that remove some (IMHO) unncessary cases of #ifdef MODULE
These basically switch off calls to MODULE_DEVICE_TABLE() macro, which already
checks for MODULE symbol on its own.

have fun
--mtx 

