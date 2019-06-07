Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE305C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 13:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EC61208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 13:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MV0TqMNQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbfFGNPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 09:15:44 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51786 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728123AbfFGNPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 09:15:44 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x57D8xbh147821;
        Fri, 7 Jun 2019 13:15:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=AnxeMW2yKku5zXHYhBhTJHK6a2GW6KArjD0e2vKaQ/Q=;
 b=MV0TqMNQDIdHKX4fGqoQ6HgR5i2eOXuB5o7ZAc5/5qKgym7Ks+VeD/Uz6nJyjMLWgArz
 3TpHKttHvA1GLnSIepjKp1bqbFDvWcsSzTWkoNxX5Dqx6LWp/mZH2XSLfWFjxm9G98oM
 rxX4d3e9kA5ktXpU4+x7xZL2D7p24CO2HaaY3k8OizWtPSguh9FTN0MEDrHIElxIV16a
 gwnYTglfpwfGQuYI2EEc3IPfoNb/Do305F/mMuiO0UoddVg2W9O1TVbMqh3b5eUHo9Pj
 0WQ7l8U3M73nTh7tMmFgjTjB/qq2kaxp9gZM+P6tmVU9A7bUhgX/epr1CV1bLr5/khWa Dg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2sugstx70v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jun 2019 13:15:34 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x57DEbC9103040;
        Fri, 7 Jun 2019 13:15:34 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2swnhbar06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jun 2019 13:15:34 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x57DFWEu031244;
        Fri, 7 Jun 2019 13:15:33 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 07 Jun 2019 06:15:32 -0700
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Hannes Reinecke <hare@suse.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jiri Kosina <trivial@kernel.org>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH trivial] [SCSI] aic7xxx: Spelling s/configuraion/configuration/
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190607112736.14004-1-geert+renesas@glider.be>
Date:   Fri, 07 Jun 2019 09:15:30 -0400
In-Reply-To: <20190607112736.14004-1-geert+renesas@glider.be> (Geert
        Uytterhoeven's message of "Fri, 7 Jun 2019 13:27:36 +0200")
Message-ID: <yq18sudleod.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9280 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=836
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906070093
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9280 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=897 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906070093
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Geert,

Applied to 5.3/scsi-queue. Thanks.

-- 
Martin K. Petersen	Oracle Linux Engineering
