Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265BBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 20:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECBD02084F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 20:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388251AbfB1UEF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 15:04:05 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:38034 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727110AbfB1UDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 15:03:44 -0500
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1SJuuvE002555;
        Thu, 28 Feb 2019 20:03:37 GMT
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        by mx0a-002e3701.pphosted.com with ESMTP id 2qxnj7gjuv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Feb 2019 20:03:36 +0000
Received: from G2W6311.americas.hpqcorp.net (g2w6311.austin.hp.com [16.197.64.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2354.austin.hpe.com (Postfix) with ESMTPS id 96DBCC6;
        Thu, 28 Feb 2019 20:03:35 +0000 (UTC)
Received: from G9W8669.americas.hpqcorp.net (16.220.49.28) by
 G2W6311.americas.hpqcorp.net (16.197.64.53) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 28 Feb 2019 20:03:23 +0000
Received: from G4W10204.americas.hpqcorp.net (2002:10cf:5210::10cf:5210) by
 G9W8669.americas.hpqcorp.net (2002:10dc:311c::10dc:311c) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Thu, 28 Feb 2019 20:03:22 +0000
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (15.241.52.13) by
 G4W10204.americas.hpqcorp.net (16.207.82.16) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Thu, 28 Feb 2019 20:03:22 +0000
Received: from AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM (10.169.7.147) by
 AT5PR8401MB0836.NAMPRD84.PROD.OUTLOOK.COM (10.169.4.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.15; Thu, 28 Feb 2019 20:03:21 +0000
Received: from AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::4dc1:79a0:953b:2cc1]) by AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::4dc1:79a0:953b:2cc1%3]) with mapi id 15.20.1665.015; Thu, 28 Feb 2019
 20:03:21 +0000
From:   "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>
To:     Erwan Velu <erwanaliasr1@gmail.com>
CC:     Erwan Velu <e.velu@criteo.com>,
        Don Brace <don.brace@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "open list:MICROSEMI SMART ARRAY SMARTPQI DRIVER (smartpqi)" 
        <esc.storagedev@microsemi.com>,
        "open list:MICROSEMI SMART ARRAY SMARTPQI DRIVER (smartpqi)" 
        <linux-scsi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] scsi: smartpqi_init: Reporting 'logical unit failure'
Thread-Topic: [PATCH] scsi: smartpqi_init: Reporting 'logical unit failure'
Thread-Index: AQHUzrn9RkWbUR+YoEiqb4hCDJ3016X1mfMg
Date:   Thu, 28 Feb 2019 20:03:20 +0000
Message-ID: <AT5PR8401MB11696B5DDB2DA774A0E584F4AB750@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
References: <20190227163133.26283-1-e.velu@criteo.com>
In-Reply-To: <20190227163133.26283-1-e.velu@criteo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [15.211.195.7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8fc903b-623c-4b84-7daa-08d69db7c9e1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB0836;
x-ms-traffictypediagnostic: AT5PR8401MB0836:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;AT5PR8401MB0836;23:8cbUtpJL+Jyy6xVQ+oDdQghsCuP8uB3Dy5iWNve?=
 =?us-ascii?Q?wInHv9+XydWSebt/6JjSfzRXJNULePcw7VoFBZyWaHAX9Ys1PqZg+aangP8k?=
 =?us-ascii?Q?WiQ/5W1aJbFevk4+WXkOrDpFV3pNCHQ5zQmbrw8qJ+uFUjhnwVWagyl6dV4L?=
 =?us-ascii?Q?do1Uk8T31+tlrTQVx8eWPYJGUL+V442tObKJapNZf5/GNmV0iXzjiVj7pw9p?=
 =?us-ascii?Q?AQ60VAASXRbCUZ77/gAyF81bvV2YlO6WVK4W+ll9bqEgCC2NeHisMHvhRluU?=
 =?us-ascii?Q?ao5iA+d7ArhHs2lEvEJMVqoKDNbRnYpYo02X2U6ZUX+9+80sm1CuJwPCtJYt?=
 =?us-ascii?Q?OQGecLqSnuyDqFi+GWdNy8ygy5anhoeVZxnnf0z+Bkr1z9wI2vlxBuuuKjMM?=
 =?us-ascii?Q?/+oo0llmh6zydVTmDk+U1FS5uqsxbz3Ws0t5T1RKHa2IFLURYkaQRF8RthTB?=
 =?us-ascii?Q?uUKjLGIRGd+kV9UlIHA13gmT+VIZ/2OCf5onWdUQkV7HjM5KjN7WvYtLa5db?=
 =?us-ascii?Q?K2XjkPKQOMudUBZCTScuWH7O/FH1Cv/xL3MUE7F403rbfnRzfz0u1hgw+Frq?=
 =?us-ascii?Q?uCcDU7Gxlv1qM7xanOPlav6puGdbOvPmcVjuTqWx9sx+kGfUjApVqeozv909?=
 =?us-ascii?Q?AQwrIY2FCJOnwzXtHVclF4xwos9QnYfW2dSOlujLL/vIAthUVi0aKVQFUuAc?=
 =?us-ascii?Q?k/gUPDN0YilVzaTiMOEJeSobf2oBpuq4gv9pzf2o/q9qLk2CmLlbLxrxEdRp?=
 =?us-ascii?Q?kLOTE/tsfmpT2D6aI2xG1Ehp7XIa65gXiSIAt0uYYOmQaHbtvDZ3qyWcKS2f?=
 =?us-ascii?Q?vNM1bJQ0qlW8iYRlZxqPxljDUJBkn5F9KGf434sDsJ3yggdi0q2bO9dDQriS?=
 =?us-ascii?Q?vScvBxpH3dGkCy5xxx7Hi6BjdApQNPlSw+Yoxrt5VuxPgUAJzIYVw8dzy+/a?=
 =?us-ascii?Q?jbSqnDxp+8ia/EDIobC6FOOjnZknLeIVw/8qeglE+zBi9jPCQmEE/Xa2/dwr?=
 =?us-ascii?Q?XG4vYt1MGZtifA6eq1D/fCCU6enuJ/0yBeG60a0uLWes2fl84cZoS4QlAgZ8?=
 =?us-ascii?Q?ZfXeD21HiBZeH2z/XVELyAhuE/L5MVxAyyk2umnPq6MVAAsbEpVHIVtmniYs?=
 =?us-ascii?Q?lKYt60Q2MiGgQ0mBAWHaohmhLsbLHEdR6J8JY7C2vVgBkjLtW66jnZK9nJzi?=
 =?us-ascii?Q?OWawfpnrhsfSrnVGTNg4wSSUQbw9t8lDtj/VN6jdvHFH2HVAI4bNUGdOUWDf?=
 =?us-ascii?Q?VJ5NaXtvE9CCVehYShhaR+ErSr5SmjF/ludt09JFl?=
x-microsoft-antispam-prvs: <AT5PR8401MB0836C519A17ADC8CFD1FDCE0AB750@AT5PR8401MB0836.NAMPRD84.PROD.OUTLOOK.COM>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(376002)(136003)(346002)(199004)(189003)(13464003)(8936002)(76176011)(7696005)(6116002)(26005)(99286004)(6246003)(229853002)(53546011)(6506007)(68736007)(71190400001)(6436002)(55016002)(9686003)(2906002)(53936002)(3846002)(66066001)(102836004)(106356001)(105586002)(71200400001)(14444005)(256004)(1411001)(11346002)(316002)(8676002)(74316002)(478600001)(186003)(446003)(14454004)(25786009)(305945005)(81156014)(486006)(7736002)(81166006)(4326008)(54906003)(5660300002)(97736004)(6916009)(33656002)(476003)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB0836;H:AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cPeQhr1k/ZcazPMwvzBP55dfKUcTsVSP/nE5rqo8eIPAOLpDMdwplk3SUhtDasZY/xQ4Big4MV09VFH4Tkx4fr0ie9Sk+ctRiW4tEtMy9yzPmrK1YevRXjVzD4NBNvVB2l+tKJLJGXnd6vKmPAAm2IUMDSuhgKWfRMvxX+QPhGvdVtyTLtA+ulwHAipBeh5A9h0wAmC3CJRBmVxUPY6ht1+Dg10ckRUbbvMD77mF/3t/CYrKOkwZjKSQ5tHaB8829HGoKb8ibJkMJ/JcxusCRysfOfUT5DzO3jXUAqLotoCd2fU9K09VSeqpEz2ilXxaQZ9GCFlg4x1yUkcC8uMW8lUfz/Iko8nLIkus4uHcTWdrctTqwhtbHSY3BUsYAkWNEfHRuy6tl9yk7YZ7WLlV8lx0x5mH08tI3zm+zxCPR34=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c8fc903b-623c-4b84-7daa-08d69db7c9e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 20:03:20.9957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB0836
X-OriginatorOrg: hpe.com
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-28_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902280134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of
> Erwan Velu
> Sent: Wednesday, February 27, 2019 10:32 AM
> Subject: [PATCH] scsi: smartpqi_init: Reporting 'logical unit failure'
> 
> When this HARDWARE_ERROR/0x3e/0x1 case is triggered, the logical volume is offlined.
> When reading the kernel log, the cause why the device got offlined isn't reported to the user.
> This situation makes difficult for admins to estimate _why_ the volume got offlined.
> Reading this part of the code makes clear this is because driver received a HARDWARE_ERROR/0x3e/0x1
> which is a 'logical unit failure'.
> 
> This patch is just about reporting that fact to help admins making a relationship between this event
> and the offlining.
> 
> Signed-off-by: Erwan Velu <e.velu@criteo.com>
> ---
>  drivers/scsi/smartpqi/smartpqi_init.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
> index f564af8949e8..89f37d76735c 100644
> --- a/drivers/scsi/smartpqi/smartpqi_init.c
> +++ b/drivers/scsi/smartpqi/smartpqi_init.c
> @@ -2764,6 +2764,12 @@ static void pqi_process_raid_io_error(struct pqi_io_request *io_request)
>  				sshdr.sense_key == HARDWARE_ERROR &&
>  				sshdr.asc == 0x3e &&
>  				sshdr.ascq == 0x1) {
> +			struct pqi_ctrl_info *ctrl_info = shost_to_hba(scmd->device->host);
> +			struct pqi_scsi_dev *device = scmd->device->hostdata;
> +
> +			dev_err(&ctrl_info->pci_dev->dev, "received 'logical unit failure' from controller
> for scsi %d:%d:%d:%d\n",
> +							ctrl_info->scsi_host->host_no, device->bus,
> +							device->target, device->lun);
>  			pqi_take_device_offline(scmd->device, "RAID");
>  			host_byte = DID_NO_CONNECT;
>  		}

Be careful printing errors per-IO; you could get thousands of them if things go bad.
The block layer print_req_error() uses printk_ratelimited(KERN_ERR) for that reason,
and the SCSI layer scsi_io_completion_action() maintains a ratelimit on its own.

The dev_err_ratelimited() macro might be a good fit here.


---
Robert Elliott, HPE Persistent Memory


